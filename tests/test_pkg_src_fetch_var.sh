: ${PKGSRCDIR:=/usr/pkgsrc}

if ! test -d PKGSRCDIR; then
    echo "Directory $PKGSRCDIR does not exit, skipping tests for pkg_src_fetch_var" 1>&2
else

   # pkg_src_fetch_var
echo x11/xxkb | pkg_src_fetch_var -f 'PKGNAME PKGPATH MAINTAINER' |
normalize_version |
cmp 'pkg_src_fetch_var #1' \
'+	xxkb-1.11	x11/xxkb	cheusov@NetBSD.org
'

fi
