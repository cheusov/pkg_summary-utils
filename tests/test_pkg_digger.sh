# pkg_digger

export PKG_DIGGER_SUMMARY=`pwd`/src_summary.txt

pkg_digger -sf | grep -E 'prefix|PKGBASE' |
cmp 'pkg_digger #1' \
'      p       prefix   Match prefixes
  empty   PKGBASE
'
