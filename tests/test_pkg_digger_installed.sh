# pkg_digger
export PKG_DIGGER_SUMMARY=`mktemp /tmp/digger.XXXXXX`
if test -z "$PKG_DIGGER_SUMMARY"; then
    exit 1
fi

pkg_digger_installed -931 pkgtools/pkg_install,pkg_install 2>&1 |
normalize_version |
cmp 'pkg_digger_installed #1' \
'pkgtools/pkg_install      - Package management and administration tools for pkgsrc
'

pkg_digger_installed -391r pkgtools/pkg_install,pkg_install 2>&1 |
normalize_version |
cmp 'pkg_digger_installed #2' \
'pkgtools/pkg_install      - Package management and administration tools for pkgsrc
'

pkg_digger_installed -13r pkgtools/pkg_install,pkg_install 2>&1 |
normalize_version |
grep -E '^(PKGNAME|PKGPATH|COMMENT|HOMEPAGE|$)' | sort |
cmp 'pkg_digger_installed #3' \
'
COMMENT=Package management and administration tools for pkgsrc
HOMEPAGE=http://www.pkgsrc.org/
PKGNAME=pkg_install-X
PKGPATH=pkgtools/pkg_install
'

pkg_digger_installed -93 pkgtools/pkg_install,pkg_install 2>&1 |
normalize_version |
grep -E '(PKGNAME|PKGPATH|COMMENT|HOMEPAGE)' | sort |
cmp 'pkg_digger_installed #4' \
'COMMENT:        Package management and administration tools for pkgsrc
HOMEPAGE:       http://www.pkgsrc.org/
PKGNAME:        pkg_install-X
PKGPATH:        pkgtools/pkg_install
'

pkg_digger_installed -19r pkgtools/pkg_install,pkg_install 2>&1 |
normalize_version |
grep -E '^(PKGNAME|PKGPATH|COMMENT|HOMEPAGE|$)' | sort |
cmp 'pkg_digger_installed #5' \
'
COMMENT=Package management and administration tools for pkgsrc
HOMEPAGE=http://www.pkgsrc.org/
PKGNAME=pkg_install-X
PKGPATH=pkgtools/pkg_install
'

pkg_digger_installed -19 pkgtools/pkg_install,pkg_install 2>&1 |
normalize_version |
grep -E '^(PKGNAME|PKGPATH|COMMENT|HOMEPAGE)' | sort |
cmp 'pkg_digger_installed #6' \
'COMMENT:        Package management and administration tools for pkgsrc
HOMEPAGE:       http://www.pkgsrc.org/
PKGNAME:        pkg_install-X
PKGPATH:        pkgtools/pkg_install
'

rm "$PKG_DIGGER_SUMMARY"
