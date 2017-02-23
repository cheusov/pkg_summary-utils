#
files_tempdir="$tmpdir/files"
rm -rf "$files_tempdir"
mkdir "$files_tempdir"

# create temporary files
rm -rf "$files_tempdir"
mkdir "$files_tempdir"
for i in vim-7.2.446nb1.tgz vim-xaw-7.2.446nb1.tgz farsight2-0.0.26nb6.tgz \
   py26-gtk2-2.24.0nb4.tgz pkg_summary.txt pkg_summary.gz pkg_summary.bz2
do
    mkdir -p "$files_tempdir"/`dirname "$i"`
    touch "$files_tempdir/$i"
done

PACKAGES="$files_tempdir"
export PACKAGES

# pkg_cleanup_distdir #1.1
{
    pkg_cleanup_packages -r bin_summary10.txt bin_summary11.txt 1>&2
    cd "$files_tempdir"
    find . | sed 's|^[.]/||'
} | sort | cmp 'pkg_cleanup_packages #1.1' \
'.
farsight2-0.0.26nb6.tgz
pkg_summary.bz2
pkg_summary.gz
pkg_summary.txt
py26-gtk2-2.24.0nb4.tgz
vim-7.2.446nb1.tgz
vim-xaw-7.2.446nb1.tgz
'

# pkg_cleanup_distdir #1.2
{
    (
	unset PACKAGES
	pkg_cleanup_packages -d "$files_tempdir" \
			     -r bin_summary10.txt bin_summary11.txt 1>&2
    )
    cd "$files_tempdir"
    find . | sed 's|^[.]/||'
} | sort | cmp 'pkg_cleanup_packages #1.2' \
'.
farsight2-0.0.26nb6.tgz
pkg_summary.bz2
pkg_summary.gz
pkg_summary.txt
py26-gtk2-2.24.0nb4.tgz
vim-7.2.446nb1.tgz
vim-xaw-7.2.446nb1.tgz
'

# pkg_cleanup_distdir #2
{
    pkg_cleanup_packages -r bin_summary11.txt 1>&2
    cd "$files_tempdir"
    find . | sed 's|^[.]/||'
} | sort | cmp 'pkg_cleanup_packages #2' \
'.
farsight2-0.0.26nb6.tgz
pkg_summary.bz2
pkg_summary.gz
pkg_summary.txt
py26-gtk2-2.24.0nb4.tgz
'
