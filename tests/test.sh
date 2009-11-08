#!/bin/sh

LC_ALL=C
export LC_ALL

#
srcdir="`pwd`/.."
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

AWKPATH="$srcdir:$OBJDIR"
PATH=$OBJDIR:$PATH

PSS_MKSCRIPTSDIR="${srcdir}"

export PKGSRCDIR BMAKE AWKPATH PATH PSS_MKSCRIPTSDIR AWKPATH

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
runtest pkg_grep_summary -m MAINTAINER 'cheusov|vle@gmx.net' < src_summary.txt |
    grep -E 'PKGNAME|PKGPATH|^$|MAINTAINER|COMMENT'

runtest pkg_grep_summary -s PKGPATH graphics/png < src_summary.txt



# pkg_cmp_summary
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.1'
pkg_cmp_summary src_summary.txt src_summary2.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.2.1'
pkg_cmp_summary -p src_summary.txt src_summary2.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.2.2'
pkg_cmp_summary --with-pkgpath src_summary.txt src_summary2.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.3'
pkg_cmp_summary src_summary4.txt src_summary5.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.4'
pkg_cmp_summary -p src_summary4.txt src_summary5.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.5.1'
pkg_cmp_summary --use-checksum src_summary4.txt src_summary5.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.5.2'
pkg_cmp_summary -c src_summary4.txt src_summary5.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.6'
pkg_cmp_summary -cp src_summary4.txt src_summary6.txt | sort -k2,2
echo '--------------------------------------------------'
echo '------- pkg_cmp_summary #1.7'
pkg_cmp_summary -P src_summary.txt src_summary2.txt | sort -k2,2



# pkg_list_all_pkgs
echo '--------------------------------------------------'
echo '------- pkg_list_all_pkgs #3'
env  pkg_list_all_pkgs |
awk '
END {
    if (NR > 7000) {
        print "XXXX"
    }else{
        print "failure"
    }
}'

normalize_version (){
  awk '{
   gsub(/(nb|alpha|beta|pre|rc|pl)[0-9]+/, "")
   gsub(/-[0-9]+([.][0-9]+)*/, "-X")
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
echo '------- pkg_refresh_summary #5.1'
pkg_refresh_summary src_summary.txt src_summary2.txt |
sed -n 's/^PKGNAME=//p' | sort

echo '--------------------------------------------------'
echo '------- pkg_refresh_summary #5.2'
pkg_refresh_summary -o src_summary.txt src_summary2.txt |
sed -n 's/^PKGNAME=//p' | sort



# pkg_src_summary
echo '--------------------------------------------------'
echo '------- pkg_src_summary #6'
pkgs="`sed -n 's/^PKGPATH=//p' src_summary.txt`"
pkg_src_summary -f PKGNAME,PKGPATH $pkgs |
tee "$objdir"/summary_full.txt |
normalize_version



echo '--------------------------------------------------'
echo '------- pkg_src_summary #7'
pkg_cmp_summary -p "$objdir"/summary_micro.txt "$objdir"/summary_full.txt |
grep -v '^='



# pkg_summary4view
echo '--------------------------------------------------'
echo '------- pkg_summary4view #8'
pkg_grep_summary -s PKGPATH 'wip/pkg_summary-utils' \
    < src_summary.txt | pkg_summary4view

echo '--------------------------------------------------'
echo '------- pkg_summary4view #8.1'
pkg_summary4view -h     2>&1 | grep pkg_summary4view >/dev/null && echo ok
pkg_summary4view --help 2>&1 | grep pkg_summary4view >/dev/null && echo ok



# pkg_uniq_summary
echo '--------------------------------------------------'
echo '------- pkg_uniq_summary #9'
pkg_uniq_summary src_summary3.txt

echo '--------------------------------------------------'
echo '------- pkg_uniq_summary #9.1'
pkg_uniq_summary -h 2>&1     | grep pkg_uniq_summary > /dev/null && echo ok1
pkg_uniq_summary --help 2>&1 | grep pkg_uniq_summary > /dev/null && echo ok2



# pkg_src_summary
echo '--------------------------------------------------'
echo '------- pkg_src_summary #10.1'
pkg_src_summary -m -fPKGNAME,PKGPATH www/ap2-python |
grep -v DEPENDS

echo '--------------------------------------------------'
echo '------- pkg_src_summary #10.2'
pkg_src_summary -m --fields PKGNAME,PKGPATH www/ap2-python:PKG_APACHE=apache2 |
grep -v DEPENDS

echo '--------------------------------------------------'
echo '------- pkg_src_summary #10.3'
pkg_src_summary -m --fields='PKGNAME PKGPATH' www/ap2-python:PYTHON_VERSION_REQD=25 |
grep -v DEPENDS

echo '--------------------------------------------------'
echo '------- pkg_src_summary #10.4'
pkg_src_summary -m -f'PKGNAME PKGPATH' \
   www/ap2-python:PYTHON_VERSION_REQD=25,PKG_APACHE=apache22 |
grep -v DEPENDS


# pkg_src_summary
echo '--------------------------------------------------'
echo '------- pkg_src_summary #11'
pkg_src_summary -A -f PKGNAME,PKGPATH \
   graphics/py-cairo:PYTHON_VERSION_REQD=25 |
grep -v DEPENDS |
pkg_grep_summary -m PKGPATH 'py-Numeric|py-cairo' |
normalize_version



# pkg_assignments2pkgpath
echo '--------------------------------------------------'
echo '------- pkg_assignments2pkgpath #12'
pkg_assignments2pkgpath -h 2>&1 |
grep pkg_assignments2pkgpath > /dev/null && echo ok1

pkg_assignments2pkgpath --help 2>&1 |
grep pkg_assignments2pkgpath > /dev/null && echo ok2



# pkg_src_fetch_var
echo '--------------------------------------------------'
echo '------- pkg_src_fetch_var #13.1'
echo x11/xxkb | pkg_src_fetch_var -f 'PKGNAME PKGPATH MAINTAINER' |
normalize_version

echo '--------------------------------------------------'
echo '------- pkg_src_fetch_var #13.2'
echo x11/xxkb | pkg_src_fetch_var -v'PKGNAME PKGPATH MAINTAINER' |
normalize_version

echo '--------------------------------------------------'
echo '------- pkg_src_fetch_var #13.3'
echo x11/xxkb | pkg_src_fetch_var --vars='PKGNAME PKGPATH MAINTAINER' |
normalize_version

echo '--------------------------------------------------'
echo '------- pkg_src_fetch_var #13.4'
echo x11/xxkb | pkg_src_fetch_var --fields 'PKGNAME PKGPATH MAINTAINER' |
normalize_version



# pkg_micro_src_summary
echo '--------------------------------------------------'
echo '------- pkg_micro_src_summary #14.1'
pkg_micro_src_summary -f PKGNAME,PKGPATH,MAINTAINER x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_micro_src_summary #14.2'
pkg_micro_src_summary --fields=PKGNAME,PKGPATH,MAINTAINER x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_micro_src_summary #14.3'
pkg_micro_src_summary -fPKGNAME,PKGPATH,MAINTAINER x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_micro_src_summary #14.4'
pkg_micro_src_summary --fields PKGNAME,PKGPATH,MAINTAINER x11/xxkb |
normalize_version



# pkg_src_summary
echo '--------------------------------------------------'
echo '------- pkg_src_summary #15.1'
pkg_src_summary -f PKGNAME --add-fields 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_src_summary #15.2'
pkg_src_summary --fields=PKGNAME -a 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_src_summary #15.3'
pkg_src_summary -fPKGNAME -aPKGPATH,MAINTAINER x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_src_summary #15.4'
pkg_src_summary -fPKGNAME --add-fields=PKGPATH,MAINTAINER x11/xxkb |
normalize_version



# pkg_src_summary
echo '--------------------------------------------------'
echo '------- pkg_src_summary #16.1'
pkg_src_summary -f PKGNAME,PKGPATH,COMMENT --rem-fields 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_src_summary #16.2'
pkg_src_summary -f PKGNAME,PKGPATH,COMMENT -r 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_src_summary #16.3'
pkg_src_summary -f PKGNAME,PKGPATH,COMMENT -rPKGPATH,MAINTAINER x11/xxkb |
normalize_version
echo '--------------------------------------------------'
echo '------- pkg_src_summary #16.4'
pkg_src_summary -f PKGNAME,PKGPATH,COMMENT --rem-fields=PKGPATH,MAINTAINER x11/xxkb |
normalize_version



# pkg_summary2build_graph
echo '--------------------------------------------------'
echo '------- pkg_summary2build_graph #17.1'
pkg_summary2build_graph src_summary.txt |
sort
echo '--------------------------------------------------'
echo '------- pkg_summary2build_graph #17.2'
pkg_summary2build_graph src_summary2.txt |
sort
echo '--------------------------------------------------'
echo '------- pkg_summary2build_graph #17.3'
pkg_summary2build_graph src_summary7.txt |
sort
echo '--------------------------------------------------'
echo '------- pkg_summary2build_graph #17.4'
pkg_summary2build_graph src_summary8.txt |
sort | uniq



# pkg_summary2deps
echo '--------------------------------------------------'
echo '------- pkg_summary2deps #18.1'
pkg_summary2deps -Apn src_summary.txt |
sort
echo '--------------------------------------------------'
echo '------- pkg_summary2deps #18.2'
pkg_summary2deps -dnt src_summary.txt |
sort
echo '--------------------------------------------------'
echo '------- pkg_summary2deps #18.4'
pkg_summary2deps -Dp src_summary8.txt |
sort | uniq
