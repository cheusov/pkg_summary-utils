#!/bin/sh

LC_ALL=C
export LC_ALL

: ${DIFF_PROG:=diff -U20}

#
print_args (){
    for i in "$@"; do
	printf " '%s'" "$i"
    done
}

runtest (){
    prog="$1"
    shift

    "$prog" "$@" 2>&1
}

grep_PKGNAME_n_PKGBASE_only (){
    grep -E '^(PKGNAME|PKGPATH)=|^$|^-' "$@"
}

tmpdir="/tmp/psu-test.$$"
mkdir -m 0700 "$tmpdir" || exit 60

tmpfn1="$tmpdir/1"
tmpfn2="$tmpdir/2"
tmpfn3="$tmpdir/3"
tmpfn4="$tmpdir/4"
tmpex="$tmpdir/5"

trap "rm -rf $tmpdir" 0 INT QUIT TERM HUP

echo > $tmpex

cmp (){
    # $1 - progress message
    # $2 - expected text
    printf '    %s... ' "$1" 1>&2

    cat > "$tmpfn2"
    printf '%s' "$2" > "$tmpfn1"

    if $DIFF_PROG "$tmpfn1" "$tmpfn2" > "$tmpfn3"; then
	echo ok
    else
	echo FAILED
	awk '{print "   " $0}' "$tmpfn3"
	rm -f $tmpex
    fi
}

summary2oneline() {
    # $1 -- no-empty string for no sorting
    awk -v first=1 '
	NF == 0 {
	    printf "\n"
	    first=1
	    next
	}
	{
	    if (!first) printf ";"
	    printf "%s", $0
	    first=0
	}' |
	if test -z "$1"; then
	    sort
	else
	    cat
	fi
}

normalize_version (){
     awk '
    /^PKGNAME[=:]/ {
        gsub(/(nb|alpha|beta|pre|rc|pl)[0-9]+$/, "")
        gsub(/[a-zA-Z]$/, "")
        gsub(/-[^-]*$/, "-X")
	gsub(/emacs[0-9]+/, "emacsX")
    }
    {  print $0  }' "$@"
}

for t in ${TESTS}; do
    . ./test_$t.sh
done

test -f "$tmpex"
exit $?
