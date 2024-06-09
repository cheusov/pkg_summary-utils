: ${PKGSRCDIR:=/usr/pkgsrc}

if ! test -d $PKGSRCDIR; then
    echo "Directory $PKGSRCDIR does not exit, skipping tests for pkg_src_summary" 1>&2
else

grep_pss_stderr (){
    grep -E 'Bad package| ----------' "$@"
}

hide_distfile_size (){
    sed 's/:[0-9]*/:NNN/g' "$@"
}

pkg_src_summary -f PKGNAME,PKGPATH -fPKGNAME,PKGPATH -btmu lang/php56 lang/php74 lang/php82 lang/php83 |
pkg_grep_summary -v -t strlist PKGBASE 'readline ncurses pkg_install-info' |
hide_distfile_size | normalize_version | grep -vE 'DEPENDS=' | summary2oneline |
cmp 'pkg_src_summary #28.1' \
'ASSIGNMENTS=PHP_VERSION_REQD=56;PKGNAME=php-X;PKGPATH=lang/php56
ASSIGNMENTS=PHP_VERSION_REQD=74;PKGNAME=php-X;PKGPATH=lang/php74
ASSIGNMENTS=PHP_VERSION_REQD=83;PKGNAME=php-X;PKGPATH=lang/php83
PKGNAME=php-X;PKGPATH=lang/php82
'

pkg_src_summary -f PKGNAME,PKGPATH -dD databases/sqlite3 |
pkg_grep_summary -v -t strlist PKGBASE 'readline ncurses pkg_install-info' |
hide_distfile_size | normalize_version | grep -vE 'DEPENDS=' | summary2oneline |
cmp 'pkg_src_summary #27.1' \
'PKGNAME=editline-X;PKGPATH=devel/editline
PKGNAME=sqlite3-X;PKGPATH=databases/sqlite3
'

for opts in -dDt -A; do
    pkg_src_summary -f PKGNAME,PKGPATH $opts databases/sqlite3 |
	pkg_grep_summary -v -t strlist PKGBASE 'nbpatch editline readline ncurses pkg_install-info' |
	hide_distfile_size | normalize_version | grep -vE 'DEPENDS=' | summary2oneline |
	cmp 'pkg_src_summary #27.3' \
'PKGNAME=checkperms-X;PKGPATH=sysutils/checkperms
PKGNAME=cwrappers-X;PKGPATH=pkgtools/cwrappers
PKGNAME=libtool-base-X;PKGPATH=devel/libtool-base
PKGNAME=mktools-X;PKGPATH=pkgtools/mktools
PKGNAME=pkgconf-X;PKGPATH=devel/pkgconf
PKGNAME=sqlite3-X;PKGPATH=databases/sqlite3
'
done

#pkg_src_summary -f PKGNAME,PKGPATH -Atb databases/sqlite3 |
#hide_distfile_size | normalize_version | grep -E 'checkperms-X|gmake-X' |
#cmp 'pkg_src_summary #27.3' \
#'PKGNAME=checkperms-X
#PKGNAME=gmake-X
#'

pkg_src_summary -fPKGNAME,PKGPATH,PLIST lang/erlang |
cut -f1 -d= | sort -u |
cmp 'pkg_src_summary #26' \
'
PKGNAME
PKGPATH
PLIST
'

pkg_src_summary -fPKGNAME,PKGPATH -F |
sort |
cmp 'pkg_src_summary #25.2' \
'PKGNAME
PKGPATH
'

pkg_src_summary -F |
sort |
cmp 'pkg_src_summary #25.1' \
'BUILD_DEPENDS
CATEGORIES
COMMENT
CONFLICTS
DEPENDS
DESCRIPTION
HOMEPAGE
LICENSE
MAINTAINER
NOTFOR
NO_BIN_ON_CDROM
NO_BIN_ON_FTP
NO_SRC_ON_CDROM
NO_SRC_ON_FTP
ONLYFOR
PKGNAME
PKGPATH
PLIST
TOOL_DEPENDS
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:PYTHON_VERSION_REQD=27 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.8' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:PYTHON_VERSION_REQD=311 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.7' \
'PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:RUBY_VERSION_REQD=33 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.6' \
'ASSIGNMENTS=RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=312;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=310;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=39;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=38;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=27;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -mu -f PKGNAME,PKGPATH \
    devel/subversion:PKG_APACHE=apache24 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.5.0' \
'PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:PKG_APACHE=apache24 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.5.1' \
'PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=312,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=312,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=310,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=310,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=39,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=39,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=38,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=38,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:RUBY_VERSION_REQD=33 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.5.2' \
'ASSIGNMENTS=RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=312;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=310;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=39;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=38;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33,PYTHON_VERSION_REQD=27;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:RUBY_VERSION_REQD=32 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.5.3' \
'PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:RUBY_VERSION_REQD=32,PYTHON_VERSION_REQD=310 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.5.4' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:RUBY_VERSION_REQD=32,PYTHON_VERSION_REQD=311 |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.5.5' \
'PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH devel/subversion |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.3' \
'PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=312,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=312,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=310,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=310,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=39,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=39,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=38,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=38,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=31;PKGNAME=subversion-X;PKGPATH=devel/subversion
ASSIGNMENTS=PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=33;PKGNAME=subversion-X;PKGPATH=devel/subversion
'

pkg_src_summary -m -f PKGNAME,PKGPATH textproc/csvtomd |
normalize_version | summary2oneline nosort |
cmp 'pkg_src_summary #23.2' \
'PKGNAME=csvtomd-X;PKGPATH=textproc/csvtomd
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=csvtomd-X;PKGPATH=textproc/csvtomd
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=csvtomd-X;PKGPATH=textproc/csvtomd
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=csvtomd-X;PKGPATH=textproc/csvtomd
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=csvtomd-X;PKGPATH=textproc/csvtomd
'

pkg_src_summary -A -f PKGNAME,PKGPATH lang/ruby > "$tmpfn1"
pkg_summary2deps -pnrA2 "$tmpfn1" 2>&1 > /dev/null |
cmp 'pkg_src_summary #21' \
''

pkg_src_summary -f PKGNAME,PLIST devel/bmake x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #20.1' \
'PKGNAME=bmake-X
PLIST=bin/bmake
PLIST=man/cat1/bmake.0
PLIST=man/man1/bmake.1

PKGNAME=xxkb-X
PLIST=bin/xxkb
PLIST=lib/X11/app-defaults/XXkb
PLIST=share/doc/xxkb/LICENSE
PLIST=share/doc/xxkb/README
PLIST=share/doc/xxkb/README.koi8
PLIST=share/xxkb/bg15.xpm
PLIST=share/xxkb/bg48.xpm
PLIST=share/xxkb/by15.xpm
PLIST=share/xxkb/by48.xpm
PLIST=share/xxkb/de15.xpm
PLIST=share/xxkb/de48.xpm
PLIST=share/xxkb/en15.xpm
PLIST=share/xxkb/en48.xpm
PLIST=share/xxkb/il15.xpm
PLIST=share/xxkb/il48.xpm
PLIST=share/xxkb/ru15.xpm
PLIST=share/xxkb/ru48.xpm
PLIST=share/xxkb/su15.xpm
PLIST=share/xxkb/su48.xpm
PLIST=share/xxkb/ua15.xpm
PLIST=share/xxkb/ua48.xpm
PLIST=${IMAKE_MAN_DIR}/xxkb.${IMAKE_MAN_SUFFIX}

'

pkg_src_summary -p -f PKGNAME,PLIST devel/bmake x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #20.2' \
'PKGNAME=bmake-X
PLIST=bin/bmake
PLIST=man/man1/bmake.1

PKGNAME=xxkb-X
PLIST=bin/xxkb
PLIST=lib/X11/app-defaults/XXkb
PLIST=share/doc/xxkb/LICENSE
PLIST=share/doc/xxkb/README
PLIST=share/doc/xxkb/README.koi8
PLIST=share/xxkb/bg15.xpm
PLIST=share/xxkb/bg48.xpm
PLIST=share/xxkb/by15.xpm
PLIST=share/xxkb/by48.xpm
PLIST=share/xxkb/de15.xpm
PLIST=share/xxkb/de48.xpm
PLIST=share/xxkb/en15.xpm
PLIST=share/xxkb/en48.xpm
PLIST=share/xxkb/il15.xpm
PLIST=share/xxkb/il48.xpm
PLIST=share/xxkb/ru15.xpm
PLIST=share/xxkb/ru48.xpm
PLIST=share/xxkb/su15.xpm
PLIST=share/xxkb/su48.xpm
PLIST=share/xxkb/ua15.xpm
PLIST=share/xxkb/ua48.xpm
PLIST=man/man1/xxkb.1

'

env PSS_SLAVES=+2 pkg_src_summary -p -f PKGNAME,PLIST x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #20.3' \
'PKGNAME=xxkb-X
PLIST=bin/xxkb
PLIST=lib/X11/app-defaults/XXkb
PLIST=share/doc/xxkb/LICENSE
PLIST=share/doc/xxkb/README
PLIST=share/doc/xxkb/README.koi8
PLIST=share/xxkb/bg15.xpm
PLIST=share/xxkb/bg48.xpm
PLIST=share/xxkb/by15.xpm
PLIST=share/xxkb/by48.xpm
PLIST=share/xxkb/de15.xpm
PLIST=share/xxkb/de48.xpm
PLIST=share/xxkb/en15.xpm
PLIST=share/xxkb/en48.xpm
PLIST=share/xxkb/il15.xpm
PLIST=share/xxkb/il48.xpm
PLIST=share/xxkb/ru15.xpm
PLIST=share/xxkb/ru48.xpm
PLIST=share/xxkb/su15.xpm
PLIST=share/xxkb/su48.xpm
PLIST=share/xxkb/ua15.xpm
PLIST=share/xxkb/ua48.xpm
PLIST=man/man1/xxkb.1

'

# pkg_src_summary
pkgs="`sed -n 's/^PKGPATH=//p' src_summary.txt`"
pkg_src_summary -f PKGNAME,PKGPATH $pkgs 2>"$tmpfn4" |
tee "$objdir"/summary_full.txt |
normalize_version | summary2oneline |
cmp 'pkg_src_summary #1' \
'PKGNAME=checkperms-X;PKGPATH=sysutils/checkperms
PKGNAME=dict-client-X;PKGPATH=textproc/dict-client
PKGNAME=dictem-X;PKGPATH=textproc/dictem
PKGNAME=emacs-X;PKGPATH=editors/emacs
PKGNAME=gmake-X;PKGPATH=devel/gmake
PKGNAME=jpeg-X;PKGPATH=graphics/jpeg
PKGNAME=libltdl-X;PKGPATH=devel/libltdl
PKGNAME=libmaa-X;PKGPATH=devel/libmaa
PKGNAME=libtool-base-X;PKGPATH=devel/libtool-base
PKGNAME=netcat-X;PKGPATH=net/netcat
PKGNAME=perl-X;PKGPATH=lang/perl5
PKGNAME=pipestatus-X;PKGPATH=devel/pipestatus
PKGNAME=pkg-config-X;PKGPATH=devel/pkg-config
PKGNAME=pkg_online-client-X;PKGPATH=wip/pkg_online-client
PKGNAME=pkg_summary-utils-X;PKGPATH=wip/pkg_summary-utils
PKGNAME=png-X;PKGPATH=graphics/png
PKGNAME=tiff-X;PKGPATH=graphics/tiff
PKGNAME=x11-links-X;PKGPATH=pkgtools/x11-links
'

grep_pss_stderr "$tmpfn4" |
cmp 'pkg_src_summary #1 stderr' \
" ------------------
Bad package wip/distbb, skipped
 ------------------
Bad package wip/pkg_online, skipped
 ------------------
Bad package wip/dict-server, skipped
 ------------------
Bad package wip/pkg_online-server, skipped
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

pkg_src_summary -m -fPKGNAME,PKGPATH www/ap2-python |
normalize_version |
grep -v DEPENDS | summary2oneline |
cmp 'pkg_src_summary #2' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=ap24-py27-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=ap24-py310-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=ap24-py312-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=ap24-py38-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=ap24-py39-python-X;PKGPATH=www/ap2-python
PKGNAME=ap24-py311-python-X;PKGPATH=www/ap2-python
'

pkg_src_summary -m --fields PKGNAME,PKGPATH www/ap2-python:PKG_APACHE=apache24 |
normalize_version |
grep -v DEPENDS | summary2oneline |
cmp 'pkg_src_summary #3' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=ap24-py27-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=ap24-py310-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=ap24-py312-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=ap24-py38-python-X;PKGPATH=www/ap2-python
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=ap24-py39-python-X;PKGPATH=www/ap2-python
PKGNAME=ap24-py311-python-X;PKGPATH=www/ap2-python
'

pkg_src_summary -m --fields='PKGNAME PKGPATH' www/ap2-python:PYTHON_VERSION_REQD=27 |
normalize_version |
grep -v DEPENDS | summary2oneline |
cmp 'pkg_src_summary #4' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=ap24-py27-python-X;PKGPATH=www/ap2-python
'

pkg_src_summary -m -f'PKGNAME PKGPATH' \
   www/ap2-python:PYTHON_VERSION_REQD=27,PKG_APACHE=apache24 |
normalize_version |
grep -v DEPENDS | summary2oneline |
cmp 'pkg_src_summary #5' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=ap24-py27-python-X;PKGPATH=www/ap2-python
'

pkg_src_summary -Af PKGNAME,PKGPATH \
   graphics/py-cairo:PYTHON_VERSION_REQD=312 |
pkg_grep_summary -s PKGBASE 'python312' |
grep -v DEPENDS |
normalize_version | summary2oneline |
cmp 'pkg_src_summary #6' \
'PKGNAME=python312-X;PKGPATH=lang/python312
'

pkg_src_summary -A -fPKGNAME,PKGPATH \
   graphics/py-cairo:PYTHON_VERSION_REQD=312 |
pkg_grep_summary -s PKGBASE 'python312' |
grep -v DEPENDS |
normalize_version | summary2oneline |
cmp 'pkg_src_summary #7' \
'PKGNAME=python312-X;PKGPATH=lang/python312
'

pkg_src_summary -mA -f PKGNAME,PKGPATH graphics/py-cairo |
pkg_grep_summary -m PKGPATH 'python|cairo' |
grep -v 'DEPENDS' |
normalize_version | summary2oneline |
cmp 'pkg_src_summary #8' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=27;PKGNAME=cairo-X;PKGPATH=graphics/cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=cairo-X;PKGPATH=graphics/cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=310;PKGNAME=py310-cairo-X;PKGPATH=graphics/py-cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=cairo-X;PKGPATH=graphics/cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=312;PKGNAME=py312-cairo-X;PKGPATH=graphics/py-cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=cairo-X;PKGPATH=graphics/cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=38;PKGNAME=py38-cairo-X;PKGPATH=graphics/py-cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=cairo-X;PKGPATH=graphics/cairo
ASSIGNMENTS=PYTHON_VERSION_REQD=39;PKGNAME=py39-cairo-X;PKGPATH=graphics/py-cairo
PKGNAME=cairo-X;PKGPATH=graphics/cairo
PKGNAME=py-cairo-shared-X;PKGPATH=graphics/py-cairo-shared
PKGNAME=py311-cairo-X;PKGPATH=graphics/py-cairo
PKGNAME=python27-X;PKGPATH=lang/python27
PKGNAME=python310-X;PKGPATH=lang/python310
PKGNAME=python311-X;PKGPATH=lang/python311
PKGNAME=python312-X;PKGPATH=lang/python312
PKGNAME=python38-X;PKGPATH=lang/python38
PKGNAME=python39-X;PKGPATH=lang/python39
'

pkg_src_summary -f PKGNAME --add-fields 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #9' \
'PKGNAME=xxkb-X
PKGPATH=x11/xxkb
MAINTAINER=cheusov@NetBSD.org

'

pkg_src_summary --fields=PKGNAME -a 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #10' \
'PKGNAME=xxkb-X
PKGPATH=x11/xxkb
MAINTAINER=cheusov@NetBSD.org

'

pkg_src_summary -fPKGNAME -aPKGPATH,MAINTAINER x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #11' \
'PKGNAME=xxkb-X
PKGPATH=x11/xxkb
MAINTAINER=cheusov@NetBSD.org

'

pkg_src_summary -fPKGNAME --add-fields=PKGPATH,MAINTAINER x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #12' \
'PKGNAME=xxkb-X
PKGPATH=x11/xxkb
MAINTAINER=cheusov@NetBSD.org

'

# pkg_src_summary
pkg_src_summary -f PKGNAME,PKGPATH,COMMENT --rem-fields 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #13' \
'PKGNAME=xxkb-X
COMMENT=XXKB - switches and indicates a current keyboard layout

'

pkg_src_summary -f PKGNAME,PKGPATH,COMMENT -r 'PKGPATH MAINTAINER' x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #14' \
'PKGNAME=xxkb-X
COMMENT=XXKB - switches and indicates a current keyboard layout

'

pkg_src_summary -f PKGNAME,PKGPATH,COMMENT -rPKGPATH,MAINTAINER x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #15' \
'PKGNAME=xxkb-X
COMMENT=XXKB - switches and indicates a current keyboard layout

'

pkg_src_summary -f PKGNAME,PKGPATH,COMMENT --rem-fields=PKGPATH,MAINTAINER x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #16' \
'PKGNAME=xxkb-X
COMMENT=XXKB - switches and indicates a current keyboard layout

'

pkg_src_summary -f PKGNAME,PKGPATH,ALLDISTFILES x11/xxkb |
hide_distfile_size | normalize_version |
cmp 'pkg_src_summary #17' \
'PKGNAME=xxkb-X
PKGPATH=x11/xxkb
ALLDISTFILES=xxkb-1.11-src.tar.gz:NNN 

'

pkg_src_summary -f PKGNAME,PKGPATH,BUILD_DEPENDS -b x11/xxkb |
awk '/^BUILD_DEPENDS=.*digest/ {print "ok"}
     /^BOOTSTRAP_DEPENDS=/ {print "bad"} ' |
cmp 'pkg_src_summary #18' \
'ok
'

pkg_src_summary -f PKGNAME,PKGPATH,ALLDISTFILES devel/bmake |
hide_distfile_size | normalize_version |
cmp 'pkg_src_summary #19' \
'PKGNAME=bmake-X
PKGPATH=devel/bmake

'

fi # test -d PKGSRCDIR
