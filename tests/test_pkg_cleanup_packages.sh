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

#
create_subdirs (){
    rm -rf "$files_tempdir"
    mkdir "$files_tempdir"
    mkdir "$files_tempdir/misc" "$files_tempdir/devel" "$files_tempdir/All"

    runawk -F= -v files_tempdir="$files_tempdir" -e '$1 == "FILE_NAME" {
	fn = $2
	print "" > (files_tempdir "/All/" fn)
	print "" > (files_tempdir "/devel/" fn)
	print "" > (files_tempdir "/misc/" fn)
    }' bin_summary10.txt bin_summary11.txt bin_summary12.txt
    touch "$files_tempdir"/SHA512.txt "$files_tempdir"/SHA512.gz \
	  "$files_tempdir"/SHA512.bz2
}

# pkg_cleanup_dir #3
create_subdirs
cat bin_summary10.txt > "$files_tempdir/All/pkg_summary.txt"
{
    pkg_cleanup_packages -r -s "$files_tempdir/All/pkg_summary.txt" 2>&1
    ( cd "$files_tempdir"; find .; )
} | sort |
cmp 'pkg_cleanup_packages #3' \
'.
./All
./All/pkg_summary.txt
./All/vim-7.2.446nb1.tgz
./All/vim-xaw-7.2.446nb1.tgz
./SHA512.bz2
./SHA512.gz
./SHA512.txt
./devel
./devel/farsight2-0.0.26nb6.tgz
./devel/gcc48-cc++-4.8.3.tgz
./devel/gcc48-libs-4.8.3.tgz
./devel/py26-gtk2-2.24.0nb4.tgz
./devel/vim-7.2.446nb1.tgz
./devel/vim-xaw-7.2.446nb1.tgz
./devel/webkit-gtk-2.4.5.tgz
./misc
./misc/farsight2-0.0.26nb6.tgz
./misc/gcc48-cc++-4.8.3.tgz
./misc/gcc48-libs-4.8.3.tgz
./misc/py26-gtk2-2.24.0nb4.tgz
./misc/vim-7.2.446nb1.tgz
./misc/vim-xaw-7.2.446nb1.tgz
./misc/webkit-gtk-2.4.5.tgz
'

# pkg_cleanup_dir #4
create_subdirs
cat bin_summary10.txt > "$files_tempdir/All/pkg_summary.txt"
{
    pkg_cleanup_packages -rss "$files_tempdir/All/pkg_summary.txt" 2>&1
    ( cd "$files_tempdir"; find .; )
} | sort |
cmp 'pkg_cleanup_packages #4' \
'.
./All
./All/pkg_summary.txt
./All/vim-7.2.446nb1.tgz
./All/vim-xaw-7.2.446nb1.tgz
./SHA512.bz2
./SHA512.gz
./SHA512.txt
./devel
./devel/vim-7.2.446nb1.tgz
./devel/vim-xaw-7.2.446nb1.tgz
./misc
./misc/vim-7.2.446nb1.tgz
./misc/vim-xaw-7.2.446nb1.tgz
'
