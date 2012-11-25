# pkg_digger

export PKG_DIGGER_SUMMARY=`pwd`/src_summary.txt

pkg_digger -sf | grep -E 'prefix|PKGBASE' |
cmp 'pkg_digger #0' \
'      p       prefix   Match prefixes
  empty   PKGBASE
'

export PKG_DIGGER_BACKEND=pkg_digger_summary

pkg_digger -1 runawk |
cmp 'pkg_digger -1 #1.1' \
'wip/runawk                - Wrapper that impelements modules for AWK
'

pkg_digger -1r runawk |
cmp 'pkg_digger -1r #1.2' \
'PKGNAME=runawk-0.14.3
PKGPATH=wip/runawk
COMMENT=Wrapper that impelements modules for AWK

'

pkg_digger -3 runawk |
cmp 'pkg_digger -3 #2.1' \
'-----------------------------------------------------------
PKGNAME:        runawk-0.14.3
PKGPATH:        wip/runawk
HOMEPAGE:       http://sourceforge.net/projects/runawk
COMMENT:        Wrapper that impelements modules for AWK
MAINTAINER:     cheusov@tut.by
CATEGORIES:     lang devel

'

pkg_digger -3r runawk |
cmp 'pkg_digger -3r #2.2' \
'PKGNAME=runawk-0.14.3
PKGPATH=wip/runawk
HOMEPAGE=http://sourceforge.net/projects/runawk
COMMENT=Wrapper that impelements modules for AWK
MAINTAINER=cheusov@tut.by
CATEGORIES=lang devel

'

pkg_digger -9 runawk |
cmp 'pkg_digger -9 #3.1' \
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

pkg_digger -9r runawk |
cmp 'pkg_digger -9r #3.2' \
'PKGNAME=runawk-0.14.3
PKGPATH=wip/runawk
BUILD_DEPENDS= checkperms>=1.1:../../sysutils/checkperms
HOMEPAGE=http://sourceforge.net/projects/runawk
COMMENT=Wrapper that impelements modules for AWK
MAINTAINER=cheusov@tut.by
CATEGORIES=lang devel
EXTRA_FIELD=lalala

'

unset PKG_DIGGER_SUMMARY PKG_DIGGER_BACKEND
