#!/bin/sh

LC_ALL=C
export LC_ALL

#
srcdir=..
if test "$OBJDIR"; then
    objdir=${OBJDIR}
else
    objdir='.'
fi

#
if test -z "$BMAKE"; then
    BMAKE=/usr/bin/make
fi
PKGSRCDIR="`pwd`/../../../.."

AWKPATH="$srcdir"

export PKGSRCDIR BMAKE AWKPATH

#
print_args (){
#    echo "$@"
    for i in "$@"; do
	printf " '%s'" "$i"
    done
}

runtest (){
    echo '--------------------------------------------------'
    printf '%s' '------- args:'
    print_args "$@"
    printf '\n'

    prog="$objdir/$1"
    shift

    "$prog" "$@" 2>&1
}

# pkg_grep_summary
runtest pkg_grep_summary PKGNAME 'fvalue ~ /^d/' < src_summary.txt
runtest pkg_grep_summary COMMENT \
    'tolower(fvalue) ~ /dictionary.*client/' < src_summary.txt | \
    grep -E 'PKGNAME|---'
runtest pkg_grep_summary -e EXFIELD < src_summary.txt | \
    grep -E 'PKGNAME|---'

# pkg_cmp_summary
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1'
pkg_cmp_summary src_summary.txt src_summary2.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #2'
pkg_cmp_summary -p src_summary.txt src_summary2.txt | sort -k2,2

# pkg_list_all_pkgs
echo '--------------------------------------------------'
echo '------- pkg_list_all_pkgs #3'
env  pkg_list_all_pkgs |
awk 'END {gsub(/[0-9]/, "X", NR); print NR}'

normalize_version (){
  awk '{
   gsub(/(nb|alpha|beta|pre|rc|pl)[0-9]+/, "")
   gsub(/[0-9]+/, "X")
   gsub(/jpeg-X.*$/, "jpeg-X")
   print $0
  }' "$@"
}

# pkg_micro_src_summary
echo '--------------------------------------------------'
echo '------- pkg_micro_src_summary #4'
pkgs="`sed -n 's/^PKGPATH=//p' src_summary.txt`"
pkg_micro_src_summary $pkgs | tee "$objdir"/summary_micro.txt |
normalize_version

# pkg_refresh_summary
echo '--------------------------------------------------'
echo '------- pkg_micro_src_summary #5'
pkg_refresh_summary src_summary.txt src_summary2.txt |
sed -n 's/^PKGNAME=//p' | sort

# pkg_src_summary
echo '--------------------------------------------------'
echo '------- pkg_src_summary #6'
pkgs="`sed -n 's/^PKGPATH=//p' src_summary.txt`"
pkg_micro_src_summary $pkgs | tee "$objdir"/summary_full.txt |
normalize_version

echo '--------------------------------------------------'
echo '------- pkg_src_summary #7'
diff "$objdir"/summary_micro.txt "$objdir"/summary_full.txt

# pkg_summary4view
echo '--------------------------------------------------'
echo '------- pkg_summary4view #8'
pkg_grep_summary PKGPATH 'fvalue == "wip/pkg_summary-utils"' \
    < src_summary.txt | pkg_summary4view