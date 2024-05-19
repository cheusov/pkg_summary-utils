: ${PKGSRCDIR:=/usr/pkgsrc}

if ! test -d $PKGSRCDIR; then
    echo "Directory $PKGSRCDIR does not exit, skipping tests for pkg_micro_src_summary" 1>&2
else

grep_pss_stderr (){
    grep -E 'Bad package| ----------' "$@"
}

summary_to_oneline() {
    awk '
/^PKGNAME=/ {printf "%s", substr($0,9)}
/^PKGPATH=/ {printf ":%s\n", substr($0,9)}
' "$@"
}

# pkg_micro_src_summary
pkgs="`sed -n 's/^PKGPATH=//p' src_summary.txt`"
pkg_micro_src_summary $pkgs 2>"$tmpfn4" |
tee "$objdir"/summary_micro.txt |
normalize_version |
summary_to_oneline |
sort |
cmp 'pkg_micro_src_summary #1' \
'checkperms-X:sysutils/checkperms
dict-client-X:textproc/dict-client
dictem-X:textproc/dictem
emacs-X:editors/emacs
gmake-X:devel/gmake
jpeg-X:graphics/jpeg
libltdl-X:devel/libltdl
libmaa-X:devel/libmaa
libtool-base-X:devel/libtool-base
netcat-X:net/netcat
perl-X:lang/perl5
pipestatus-X:devel/pipestatus
pkg-config-X:devel/pkg-config
pkg_summary-utils-X:wip/pkg_summary-utils
png-X:graphics/png
tiff-X:graphics/tiff
x11-links-X:pkgtools/x11-links
'

grep_pss_stderr "$tmpfn4" |
cmp 'pkg_micro_src_summary #1 stderr' \
" ------------------
Bad package wip/distbb, skipped
 ------------------
Bad package wip/pkg_online, skipped
 ------------------
Bad package wip/dict-server, skipped
 ------------------
Bad package wip/pkg_online-server, skipped
 ------------------
Bad package wip/pkg_online-client, skipped
 ------------------
Bad package wip/paexec, skipped
 ------------------
Bad package wip/runawk, skipped
 ------------------
Bad package graphics/libungif, skipped
 ------------------
Bad package wip/dict-client, skipped
 ------------------
Bad package wip/awk-pkgsrc-dewey, skipped
 ------------------
Bad package www/ap22-vhost-ldap, skipped
 ------------------
Bad package www/ap2-vhost-ldap:PKG_APACHE=apache2, skipped
"

pkg_micro_src_summary -f PKGNAME,PKGPATH,MAINTAINER x11/xxkb |
normalize_version |
cmp 'pkg_micro_src_summary #2' \
'PKGNAME=xxkb-X
PKGPATH=x11/xxkb
MAINTAINER=cheusov@NetBSD.org

'

pkg_micro_src_summary -fPKGNAME,PKGPATH,MAINTAINER x11/xxkb |
normalize_version |
cmp 'pkg_micro_src_summary #3' \
'PKGNAME=xxkb-X
PKGPATH=x11/xxkb
MAINTAINER=cheusov@NetBSD.org

'

fi # test -d PKGSRCDIR
