test: .PHONY
test: all
	@set -e; \
	unset MAKEFLAGS; \
	export PREFIX; \
	export AWKPATH=${SRCDIR_common}:${SRCDIR_pkgsrc_dewey}:${SRCDIR_pkg_grep_summary}; \
	export TESTS=${.CURDIR:T}; \
	export SIG_HANDLER_DIR=${SRCDIR_common}; \
	export XB2BIN_SUMMARYDIR=${OBJDIR_XB2bin_summary}; \
	export GREP_LIBEXECDIR=${OBJDIR_pkg_grep_summary}; \
	export SUMMARY2MULTI_VARIANTSDIR=${OBJDIR_summary2multi_variants}; \
	export LIBEXECDIR=${.OBJDIR}; \
	export PKGDIG_SYSCONFDIR=${OBJDIR_pkg_digger}; \
	export PSS_MKSCRIPTSDIR=${OBJDIR_pkg_src_summary}; \
	export PATH=${OBJDIR_pkg_src_fetch_var}:${OBJDIR_pkg_src_summary}:${OBJDIR_pkg_summary4view}:${OBJDIR_pkg_digger_summary}:${OBJDIR_pkg_uniq_summary}:${OBJDIR_pkg_summary2deps}:${OBJDIR_pkg_enrich_summary}:${OBJDIR_cvs_checksum}:${OBJDIR_pkg_cleanup_dir}:${OBJDIR_pkg_bin_summary}:${OBJDIR_pkg_digger_summary}:${OBJDIR_pkg_src_summary}:${OBJDIR_summary2multi_variants}:${OBJDIR_XB2bin_summary}:${OBJDIR_pkg_grep_summary}:${.CURDIR:Q}:${OBJDIR:Q}:${.OBJDIR:Q}:"$$PATH"; \
	cd ../tests; \
	${SH} ./test.sh

.export PKG_INFO_CMD
