#
files_tempdir="$tmpdir/files"
rm -rf "$files_tempdir"
mkdir "$files_tempdir"

runawk -F= -v files_tempdir="$files_tempdir" -e '$1 == "FILE_NAME" {
    fn = (files_tempdir "/" $2)
    print "" > fn
    close(fn)
}' bin_summary10.txt bin_summary11.txt bin_summary12.txt

touch "$files_tempdir"/pkg_summary.txt "$files_tempdir"/pkg_summary.gz \
      "$files_tempdir"/pkg_summary.bz2

# pkg_cleanup_dir #1
pkg_cleanup_dir -d "$files_tempdir" -f FILE_NAME /dev/null 2>&1 |
    sort |
cmp 'pkg_cleanup_dir #1' \
'farsight2-0.0.26nb6.tgz
gcc48-cc++-4.8.3.tgz
gcc48-libs-4.8.3.tgz
pkg_summary.bz2
pkg_summary.gz
pkg_summary.txt
py26-gtk2-2.24.0nb4.tgz
vim-7.2.446nb1.tgz
vim-xaw-7.2.446nb1.tgz
webkit-gtk-2.4.5.tgz
'

# pkg_cleanup_dir #2
pkg_cleanup_dir -d "$files_tempdir" -f FILE_NAME \
		-x 'pkg_summary.txt pkg_summary.gz pkg_summary.bz2' \
		bin_summary12.txt |
    sort |
cmp 'pkg_cleanup_dir #2' \
'farsight2-0.0.26nb6.tgz
py26-gtk2-2.24.0nb4.tgz
vim-7.2.446nb1.tgz
vim-xaw-7.2.446nb1.tgz
'

# pkg_cleanup_dir #3
pkg_cleanup_dir -d "$files_tempdir" -f FILE_NAME \
		bin_summary10.txt bin_summary11.txt bin_summary12.txt |
    sort |
cmp 'pkg_cleanup_dir #3' \
'pkg_summary.bz2
pkg_summary.gz
pkg_summary.txt
'

# pkg_cleanup_dir #4
{ pkg_cleanup_dir -d "$files_tempdir" -f FILE_NAME \
		-x 'pkg_summary.txt pkg_summary.gz pkg_summary.bz2' \
		-r bin_summary12.txt; cd "$files_tempdir"; find .; } |
    sort |
    cmp 'pkg_cleanup_dir #4' \
'.
./gcc48-cc++-4.8.3.tgz
./gcc48-libs-4.8.3.tgz
./pkg_summary.bz2
./pkg_summary.gz
./pkg_summary.txt
./webkit-gtk-2.4.5.tgz
'

# pkg_cleanup_dir #5
rm -rf "$files_tempdir"
mkdir "$files_tempdir"
for i in ccc-subdir/ccc-0.0.tgz ccc-subdir/ccc-0.0.patch1 \
   ccc-subdir/ccc-0.0.patch2 \
   ccc1-subdir/ccc-1.1.tgz ccc1-subdir/ccc-1.1.patch1   ccc1-subdir/ccc-1.1.patch2
do
    mkdir -p "$files_tempdir"/`dirname "$i"`
    touch "$files_tempdir/$i"
done

{
    pkg_cleanup_dir -d "$files_tempdir/" -f ALLSRCFILES \
		    -r src_summary16.txt 2>&1
    ( cd "$files_tempdir"; find .; )
} | sort |
cmp 'pkg_cleanup_dir #5' \
'.
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
}

# pkg_cleanup_dir #6
create_subdirs
{
    pkg_cleanup_dir -r -d "$files_tempdir" -f FILE_NAME \
	bin_summary10.txt bin_summary11.txt bin_summary12.txt 2>&1
    ( cd "$files_tempdir"; find .; )
} | sort |
cmp 'pkg_cleanup_dir #6' \
'.
'

# pkg_cleanup_dir #7
create_subdirs
{
    pkg_cleanup_dir -r -d "$files_tempdir" -f FILE_NAME \
	-I bin_summary10.txt bin_summary11.txt bin_summary12.txt 2>&1
    ( cd "$files_tempdir"; find .; )
} | sort |
cmp 'pkg_cleanup_dir #7' \
'.
./All
./All/farsight2-0.0.26nb6.tgz
./All/gcc48-cc++-4.8.3.tgz
./All/gcc48-libs-4.8.3.tgz
./All/py26-gtk2-2.24.0nb4.tgz
./All/vim-7.2.446nb1.tgz
./All/vim-xaw-7.2.446nb1.tgz
./All/webkit-gtk-2.4.5.tgz
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
