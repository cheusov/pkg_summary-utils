/*
* Copyright (c) 2014, Aleksey Cheusov <vle@gmx.net>
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are
* met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above
*       copyright notice, this list of conditions and the following
*       disclaimer in the documentation and/or other materials provided
*       with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
* HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
* THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include <ctype.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <search.h>
#include <errno.h>
#include <regex.h>

#define HASHVAL_FIELD (((char *)0) + 1)
#define HASHVAL_ITEM  (((char *)0) + 2)

#if !HAVE_FUNC3_STRLCPY
size_t strlcpy(char *dst, const char *src, size_t size);
#endif

#if !HAVE_FUNC3_STRLCAT
size_t strlcat(char *dst, const char *src, size_t size);
#endif

typedef enum {
	strat_bad,
	strat_empty,
	strat_exact,
	strat_prefix,
	strat_suffix,
	strat_strlist,
	strat_strfile,
	strat_substring,
	strat_first,
	strat_last,
	strat_word,
	strat_re,
} strat_t;
static strat_t strat = strat_bad;

static int ic = 0;

static int invert = 0;

static int error = 0;

static int verbose = 0;

static int found_cnt = 0;

typedef enum {
	field_normal,
	field_PKGPATH,
	field_PKGBASE,
	field_PKGPATHe,
	field_PKGPABA,
	field_PKGPANA,
} field_id_t;
static char *field = NULL;
static size_t field_len = 0;
static field_id_t field_id = field_normal;
static int field_multiline = 0;

static char *cond = NULL;
static size_t cond_len = 0;

typedef enum {
	match_unknown, match_yes, match_no,
} match_t;
static match_t match = match_unknown;

static char *summary = NULL;
static int summary_sz = 0; /* without 0-terminator */
static int summary_allocated = 0;

static char PKGNAME [512] = "";
static char PKGPATH [512] = "";
static char ASSIGNMENTS [512] = "";

static char *output_fields = NULL;

static regex_t regexp;

/**************************************/

static void *xrealloc(void *ptr, size_t size)
{
        void *ret = realloc (ptr, size);
        if (!ret){
                perror ("realloc(3) failed");
                exit (1);
        }

        return ret;
}

static char *xstrdup (const char *s)
{
        char *ret = strdup (s);
        if (!ret){
                perror ("strdup(3) failed");
                exit (1);
        }

        return ret;
}

/**************************************/

static void strlwr (char *p)
{
	for (; *p; ++p){
		*p = tolower ((int) (unsigned char) *p);
	}
}

/**************************************/

static void set_strat (const char *s)
{
	int i;

	static const struct { strat_t id; const char name [10]; } ids [] = {
		{strat_empty,   "empty"},
		{strat_exact,   "exact"},
		{strat_prefix,  "prefix"},
		{strat_suffix,  "suffix"},
		{strat_strlist, "strlist"},
		{strat_strfile, "strfile"},
		{strat_substring, "substring"},
		{strat_first,   "first"},
		{strat_last,    "last"},
		{strat_word,    "word"},
		{strat_re,      "re"},
	};

	for (i=0; i < sizeof (ids)/sizeof (ids [0]); ++i){
		if (!strcmp (ids [i].name, s)){
			strat = ids [i].id;
			return;
		}
	}

	fprintf (stderr, "Unknown search strategy: %s\n", s);
	exit (1);
}

static void set_field (const char *f)
{
	int i;

	static const char ml_fields [][14] = {
		"PLIST",
		"DESCRIPTION",
		"DEPENDS",
		"REQUIRES",
		"PROVIDES",
		"CONFLICTS",
	};

	static const struct { field_id_t id; const char name [9]; } ids [] = {
		{field_PKGBASE,  "PKGBASE"},
		{field_PKGPATH,  "PKGPATH"},
		{field_PKGPATHe, "PKGPATHe"},
		{field_PKGPABA,  "PKGPABA"},
		{field_PKGPABA,  "PKGPAIR"},
		{field_PKGPANA,  "PKGPANA"},
	};

	field_id = field_normal;

	for (i=0; i < sizeof (ids)/sizeof (ids [0]); ++i){
		if (!strcmp (ids [i].name, f)){
			field_id = ids [i].id;
			break;
		}
	}

	for (i=0; i < sizeof (ml_fields)/sizeof (ml_fields [0]); ++i){
		if (!strcmp (ml_fields [i], f)){
			field_multiline = 1;
			break;
		}
	}
}

static void process_args (int *argc, char ***argv)
{
	int ch;

	while (ch = getopt (*argc, *argv, "ivt:f:rR"), ch != -1){
		switch (ch) {
			case 'i':
				ic = 1;
				break;
			case 'v':;
				invert = 1;
				break;
			case 't':
				set_strat (optarg);
				break;
			case 'f':
				if (optarg && optarg [0])
					output_fields = xstrdup (optarg);
				break;
			case 'r':
				error = 1;
				break;
			case 'R':
				error = 1;
				verbose = 1;
				break;
			case '?':
			default:
				exit (2);
		}
	}
	*argc -= optind;
	*argv += optind;
}

static int process_line_empty (char *value, size_t value_len)
{
	return value [0] == 0;
}

static int process_line_exact (char *value, size_t value_len)
{
	return cond_len == value_len && !memcmp (value, cond, cond_len);
}

static int process_line_prefix (char *value, size_t value_len)
{
	return cond_len <= value_len && !memcmp (value, cond, cond_len);
}

static int process_line_suffix (char *value, size_t value_len)
{
	return cond_len <= value_len &&
		!memcmp (value+value_len-cond_len, cond, cond_len);
}

static int process_line_strlist (char *value, size_t value_len)
{
	ENTRY e;
	ENTRY *found;

	e.key  = value;
	e.data = NULL;
	found = hsearch (e, FIND);
	return (found && found->data == HASHVAL_ITEM);
}

static int process_line_substring (char *value, size_t value_len)
{
	if (cond_len > value_len)
		return 0;
	else if (cond_len == value_len)
		return process_line_exact (value, value_len);

	return strstr (value, cond) != NULL;
}

static int process_line_first (char *value, size_t value_len)
{
	int ch;
	if (!process_line_prefix (value, value_len))
		return 0;

	ch = (unsigned char) value [cond_len];
	return !isalnum (ch) && ch != '_';
}

static int process_line_last (char *value, size_t value_len)
{
	int ch;
	if (cond_len == value_len)
		return process_line_exact (value, value_len);

	if (!process_line_suffix (value, value_len))
		return 0;

	ch = (unsigned char) value [value_len - cond_len - 1];
	return !isalnum (ch) && ch != '_';
}

static int process_line_word (char *value, size_t value_len)
{
	char *p;
	int ch;

	if (cond_len > value_len)
		return 0;
	else if (cond_len == value_len)
		return process_line_exact (value, value_len);

	p = strstr (value, cond);
	while (p){
		if (p != value){
			ch = (unsigned char) p [-1];
			if (isalnum (ch) || ch == '_')
				goto next_it;
		}

		ch = (unsigned char) p [cond_len];
		if (!isalnum (ch) && ch != '_')
			return 1;

	next_it:
		p = strstr (p+1, cond);
	}

	return 0;
}

static int process_line_re (char *value, size_t value_len)
{
	char errbuf [256];
	int ret = regexec (&regexp, value, 0, NULL, 0);
	if (ret == 0)
		return 1;
	else if (ret == REG_NOMATCH)
		return 0;

	regerror (ret, &regexp, errbuf, sizeof (errbuf));
	fprintf (stderr, "%s\n", errbuf);
	exit (1);
}

typedef int (*process_line_t) (char *, size_t);
static const process_line_t funcs [] = {
	NULL,
	process_line_empty,
	process_line_exact,
	process_line_prefix,
	process_line_suffix,
	process_line_strlist,
	process_line_strlist, /* the same */
	process_line_substring,
	process_line_first,
	process_line_last,
	process_line_word,
	process_line_re,
};

static int interesting_field (char *line)
{
	int ret;
	char *eq;
	ENTRY e;
	ENTRY *found;

	if (!output_fields)
		return 1;

	eq = strchr (line, '=');
	if (eq)
		*eq = 0;

	e.key  = line;
	e.data = NULL;
	found = hsearch (e, FIND);
	ret = (found && found->data == HASHVAL_FIELD);

	if (eq)
		*eq = '=';

	return ret;
}

static void process_line (char *line, size_t line_len)
{
	char *value = strchr (line, '=');
	char *p;
	size_t len, value_len, curr_field_len;
	int ret;
	int run_func = 0;

	assert (match == match_unknown);

	if (!value){
		fprintf (stderr, "bad line: `%s`\n", line);
		exit (1);
	}
	assert (value);

	curr_field_len = value - line;

	++value;
	value_len = line_len - (value - line);

	switch (field_id){
		case field_normal:
			run_func = (field_len == curr_field_len &&
						!memcmp (field, line, field_len));
			break;
		case field_PKGPATH:
			run_func = (7 == curr_field_len &&
						!memcmp ("PKGPATH", line, 7));
			if (run_func){
				p = strchr (value, ':');
				if (p){
					*p = 0;
					strlcpy (PKGPATH, value, sizeof (PKGPATH));
					value = PKGPATH;
					value_len = strlen (PKGPATH);
					*p = ':';
				}
			}
			break;
		case field_PKGBASE:
			run_func = (curr_field_len == 7 &&
						!memcmp ("PKGNAME", line, 7));
			if (run_func){
				p = strrchr (value, '-');
				if (p){ /* p == NULL if PKGNAME is broken */
					*p = 0;
					strlcpy (PKGNAME, value, sizeof (PKGNAME));
					value = PKGNAME;
					value_len = strlen (PKGNAME);
					*p = '-';
				}
			}
			break;
		case field_PKGPABA:
		case field_PKGPANA:
			if (curr_field_len == 7 && !memcmp ("PKGNAME", line, 7)){
				strlcpy (PKGNAME, value, sizeof (PKGNAME));
				if (field_id == field_PKGPABA){
					p = strrchr (PKGNAME, '-');
					if (p) /* p == NULL if PKGNAME is broken */
						*p = 0;
				}
			}else if (curr_field_len == 7 && !memcmp ("PKGPATH", line, 7)){
				strlcpy (PKGPATH, value, sizeof (PKGPATH));
				/* FIXME: strip :var=val,var=val from PKGPATH? */
			}

			if (PKGPATH [0] && PKGNAME [0]){
				strlcat (PKGPATH, ",", sizeof (PKGPATH));
				strlcat (PKGPATH, PKGNAME, sizeof (PKGPATH));
				value     = PKGPATH;
				value_len = strlen (PKGPATH);
				run_func  = 1;
			}
			break;
		case field_PKGPATHe:
			if (curr_field_len == 11 && !memcmp ("ASSIGNMENTS", line, 11)){
				strlcpy (ASSIGNMENTS, value, sizeof (ASSIGNMENTS));
			}else if (curr_field_len == 7 && !memcmp ("PKGPATH", line, 7)){
				strlcpy (PKGPATH, value, sizeof (PKGPATH));
			}

			if (PKGPATH [0] && ASSIGNMENTS [0]){
				strlcat (PKGPATH, ":", sizeof (PKGPATH));
				strlcat (PKGPATH, ASSIGNMENTS, sizeof (PKGPATH));
				value     = PKGPATH;
				value_len = strlen (PKGPATH);
				run_func  = 1;
			}
			break;
	}

	if (run_func){
		if (ic)
			strlwr (value);

		assert (strlen (value) == value_len); /* FIXME: remove me */
		ret = funcs [strat] (value, value_len);

		if (invert)
			ret = 1 - ret;

		if (ret){
			match = match_yes;
			if (summary && summary [0])
				printf ("%s", summary);
		}else if (!field_multiline){
			match = match_no;
		}
	}

	switch (match){
		case match_yes:
			if (interesting_field (line))
				puts (line);
			break;

		case match_unknown:
			if (interesting_field (line)){
				len = strlen (line);
				if (summary_sz+len+2 >= summary_allocated){
#if 0
					summary_allocated = summary_allocated + len + 2;
#else
					summary_allocated = summary_allocated * 5 / 4 + len + 16384;
#endif
					summary = xrealloc (summary, summary_allocated);
				}

				memcpy (summary + summary_sz, line, len);
				summary_sz += len;
				summary [summary_sz] = '\n';
				++summary_sz;
				summary [summary_sz] = '\0';
			}
			break;
		default:
			break;
	}
}

static void end_summary (void)
{
	int ret;
	if (match == match_unknown){
		if (field_id == field_PKGPATHe && PKGPATH [0]){
			ret = funcs [strat] (PKGPATH, strlen (PKGPATH));
			if (invert)
				ret = 1 - ret;

			if (ret){
				match = match_yes;
				if (summary && summary [0])
					printf ("%s", summary);
			}
		}

		if (match == match_unknown && strat == strat_empty){
			if (!invert){
				match = match_yes;
				if (summary && summary [0])
					printf ("%s", summary);
			}
		}
	}

	if (match == match_yes){
		++found_cnt;
		printf ("\n");
	}

	match = match_unknown;
	summary_sz = 0;
	if (summary)
		summary [0] = 0;

	PKGNAME [0] = 0;
	PKGPATH [0] = 0;
	ASSIGNMENTS [0] = 0;
}

static void read_summaries (void)
{
	char *buf = NULL;
	ssize_t len = 0;
	size_t linesize = 0;

	while (len = getline (&buf, &linesize, stdin), len != -1) {
		if (len && buf [len-1] == '\n'){
			--len;
			buf [len] = 0;
		}

		if (len){
			if (match == match_unknown){
				process_line (buf, len);
			}else if (match == match_yes){
				if (interesting_field (buf))
					puts (buf);
			}
		}else{
			end_summary ();
		}
	}

	if (ferror (stdin))
		perror ("getline(3) failed");
}

static void set_field_n_cond (int argc, char **argv)
{
	switch (strat){
		case strat_bad:
			exit (3);

		default:
			assert (argc == 2);

			field = argv [0];
			field_len = strlen (field);
			set_field (field);

			cond  = argv [1];
			cond_len = strlen (cond);
			if (ic)
				strlwr (cond);

			break;
	}
}

static void tokenize (char *p, const char *sep, void (*func) (const char *))
{
	char *token = strtok (p, sep);
	if (token)
		func (token);

	while (token = strtok (NULL, sep), token != NULL){
		func (token);
	}
}

static void add_field (const char *f)
{
	ENTRY e;
	e.key  = strdup (f);
	e.data = HASHVAL_FIELD;
	if (!hsearch (e, ENTER)){
		perror ("hsearch(3) failed");
		exit (1);
	}
}

static void process_output_fields (void)
{
	if (output_fields)
		tokenize (output_fields, " ,", add_field);
}

static void free_memory (void)
{
	hdestroy ();

	if (summary)
		free (summary);

	if (output_fields)
		free (output_fields);
}

static void add_cond (const char *c)
{
	ENTRY e;
	e.key  = strdup (c);
	e.data = HASHVAL_ITEM;
	if (!hsearch (e, ENTER)){
		perror ("hsearch(3) failed");
		exit (1);
	}
}

static void postproc_cond (void)
{
	char errbuf [256];
	FILE *fp   = NULL;
	char *line = NULL;
	size_t linesize = 0;
	ssize_t len     = 0;
	int ret         = 0;

	switch (strat){
		case strat_strlist:
			tokenize (cond, " ", add_cond);
			break;
		case strat_strfile:
			fp = fopen (cond, "r");
			if (!fp){
				fprintf (stderr, "Cannot open file %s: %s\n", cond, strerror (errno));
				exit (1);
			}

			while (len = getline (&line, &linesize, fp), len != -1){
				if (len && line [len-1] == '\n'){
					--len;
					line [len] = 0;
				}
				tokenize (line, " ", add_cond);
			}

			if (ferror (stdin))
				perror ("getline(3) failed");

			fclose (fp);
			break;
		case strat_re:
			ret = regcomp (&regexp, cond, REG_EXTENDED | REG_NOSUB);
			if (ret){
				regerror (ret, &regexp, errbuf, sizeof (errbuf));
				fprintf (stderr, "%s\n", errbuf);
				exit (1);
			}
			break;
		default:
			break;
	}
}

static void create_hash (void)
{
	int ht_size = 200;

	if (strat == strat_strlist)
		ht_size = 50000;

	if (!hcreate (ht_size)){
		perror ("hcreate(3) failed");
		exit (1);
	}
}

int main (int argc, char **argv)
{
	process_args (&argc, &argv);
	create_hash ();
	set_field_n_cond (argc, argv);
	postproc_cond ();
	process_output_fields ();
	read_summaries ();

	free_memory ();

	if (!error || found_cnt){
		return 0;
	}else{
		if (verbose)
			fprintf (stderr, "No matches found\n");

		return 1;
	}
}
