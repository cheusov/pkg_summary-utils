#
files_tempdir="$tmpdir/files"
rm -rf "$files_tempdir"
mkdir "$files_tempdir"

# create temporary files
rm -rf "$files_tempdir"
mkdir "$files_tempdir"
for i in ccc-subdir/ccc-0.0.tgz ccc-subdir/ccc-0.0.patch1 \
   ccc-subdir/ccc-0.0.patch2 \
   ccc1-subdir/ccc-1.1.tgz ccc1-subdir/ccc-1.1.patch1   ccc1-subdir/ccc-1.1.patch2
do
    mkdir -p "$files_tempdir"/`dirname "$i"`
    touch "$files_tempdir/$i"
done

DISTDIR="$files_tempdir"
export DISTDIR

# pkg_cleanup_distdir #1.1
{
    pkg_cleanup_distdir -r src_summary.txt 1>&2
    cd "$files_tempdir"
    find . | sed 's|^[.]/||'
} | sort | cmp 'pkg_cleanup_distdir #1.1' \
'.
ccc-subdir
ccc-subdir/ccc-0.0.patch1
ccc-subdir/ccc-0.0.patch2
ccc-subdir/ccc-0.0.tgz
ccc1-subdir
ccc1-subdir/ccc-1.1.patch1
ccc1-subdir/ccc-1.1.patch2
ccc1-subdir/ccc-1.1.tgz
'

# pkg_cleanup_distdir #1.2
{
    (
	unset DISTDIR
	pkg_cleanup_distdir -d "$files_tempdir" -r src_summary.txt 1>&2
    )
    cd "$files_tempdir"
    find . | sed 's|^[.]/||'
} | sort | cmp 'pkg_cleanup_distdir #1.2' \
'.
ccc-subdir
ccc-subdir/ccc-0.0.patch1
ccc-subdir/ccc-0.0.patch2
ccc-subdir/ccc-0.0.tgz
ccc1-subdir
ccc1-subdir/ccc-1.1.patch1
ccc1-subdir/ccc-1.1.patch2
ccc1-subdir/ccc-1.1.tgz
'

# pkg_cleanup_distdir #2
{
    pkg_cleanup_distdir -r src_summary16.txt 1>&2
    cd "$files_tempdir"
    find . | sed 's|^[.]/||'
} | sort | cmp 'pkg_cleanup_distdir #2' \
'.
'
