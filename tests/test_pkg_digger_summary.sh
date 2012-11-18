# pkg_digger
export PKG_DIGGER_SUMMARY=`pwd`/src_summary.txt

pkg_digger_summary -931 wip/runawk,runawk |
cmp 'pkg_digger_summary -1 #1' \
'wip/runawk                - Wrapper that impelements modules for AWK
'

pkg_digger_summary -391r wip/runawk,runawk |
cmp 'pkg_digger_summary -1r #1.1' \
'wip/runawk                - Wrapper that impelements modules for AWK
'

pkg_digger_summary -13r wip/runawk,runawk |
cmp 'pkg_digger_summary -3r #2' \
'PKGNAME=runawk-0.14.3
PKGPATH=wip/runawk
HOMEPAGE=http://sourceforge.net/projects/runawk
COMMENT=Wrapper that impelements modules for AWK
MAINTAINER=cheusov@tut.by
CATEGORIES=lang devel

'

pkg_digger_summary -93 wip/runawk,runawk |
cmp 'pkg_digger_summary -3 #2.1' \
'-----------------------------------------------------------
PKGNAME:        runawk-0.14.3
PKGPATH:        wip/runawk
HOMEPAGE:       http://sourceforge.net/projects/runawk
COMMENT:        Wrapper that impelements modules for AWK
MAINTAINER:     cheusov@tut.by
CATEGORIES:     lang devel

'

pkg_digger_summary -19r wip/runawk,runawk |
cmp 'pkg_digger_summary -9r #3' \
'PKGNAME=runawk-0.14.3
PKGPATH=wip/runawk
BUILD_DEPENDS= checkperms>=1.1:../../sysutils/checkperms
HOMEPAGE=http://sourceforge.net/projects/runawk
COMMENT=Wrapper that impelements modules for AWK
MAINTAINER=cheusov@tut.by
CATEGORIES=lang devel
EXTRA_FIELD=lalala

'

pkg_digger_summary -1i wip/runawk,runawk |
cmp 'pkg_digger_summary -i #3.1' \
'-----------------------------------------------------------
PKGNAME:        runawk-0.14.3
PKGPATH:        wip/runawk
BUILD_DEPENDS:  checkperms>=1.1:../../sysutils/checkperms
HOMEPAGE:       http://sourceforge.net/projects/runawk
COMMENT:        Wrapper that impelements modules for AWK
MAINTAINER:     cheusov@tut.by
CATEGORIES:     lang devel
EXTRA_FIELD:    lalala

'

pkg_digger_summary MAINTAINER:prefix:cheusov@ |
sort -u |
cmp 'pkg_digger_summary fsq #4.1' \
'devel/libmaa,libmaa
devel/pipestatus,pipestatus
textproc/dictem,dictem
wip/awk-pkgsrc-dewey,awk-pkgsrc-dewey
wip/dict-client,dict-client
wip/dict-server,dict-server
wip/distbb,distbb
wip/paexec,paexec
wip/pkg_online,pkg_online
wip/pkg_online-client,pkg_online-client
wip/pkg_online-server,pkg_online-server
wip/pkg_summary-utils,pkg_summary-utils
wip/runawk,runawk
'

pkg_digger_summary \
   'MAINTAINER:exact:cheusov@tut.by' \
   PKGBASE:substring:jpeg \
   COMMENT:word:language |
sort -u |
cmp 'pkg_digger_summary fsq #4.2' \
'devel/libmaa,libmaa
devel/pipestatus,pipestatus
graphics/jpeg,jpeg
lang/perl5,perl
textproc/dictem,dictem
wip/awk-pkgsrc-dewey,awk-pkgsrc-dewey
wip/dict-client,dict-client
wip/dict-server,dict-server
wip/distbb,distbb
wip/paexec,paexec
wip/pkg_online,pkg_online
wip/pkg_online-client,pkg_online-client
wip/pkg_online-server,pkg_online-server
wip/pkg_summary-utils,pkg_summary-utils
wip/runawk,runawk
'

pkg_digger_summary -n5 \
   'MAINTAINER:exact:cheusov@tut.by' \
   PKGBASE:substring:jpeg \
   COMMENT:word:language |
awk 'END {print NR}' |
cmp 'pkg_digger_summary fsq #4.2' \
'5
'

pkg_digger_summary 'UNKNOWN:exact:badstring' 2>&1 |
cmp 'pkg_digger_summary fsq #5.1' \
'No matches found
'

pkg_digger_summary -q 'UNKNOWN:exact:badstring' 2>&1 |
cmp 'pkg_digger_summary fsq #5.2' \
''

pkg_digger_summary -f |
cmp 'pkg_digger_summary -f #6' \
'ASSIGNMENTS
BUILD_DEPENDS
CATEGORIES
COMMENT
CONFLICTS
DEPENDS
EXFIELD
EXTRA_FIELD
HOMEPAGE
MAINTAINER
PKGBASE
PKGNAME
PKGPABA
PKGPAIR
PKGPANA
PKGPATH
PKGPATHe
'

pkg_digger_summary -f |
cmp 'pkg_digger_summary -s #7' \
'ASSIGNMENTS
BUILD_DEPENDS
CATEGORIES
COMMENT
CONFLICTS
DEPENDS
EXFIELD
EXTRA_FIELD
HOMEPAGE
MAINTAINER
PKGBASE
PKGNAME
PKGPABA
PKGPAIR
PKGPANA
PKGPATH
PKGPATHe
'
