grep_pss_stderr (){
    grep -E 'Bad package| ----------' "$@"
}

# pkg_src_summary -m -f \
#     PKGNAME,PKGPATH devel/subversion:RUBY_VERSION_REQD=193,PKG_APACHE=apache2 \
#     devel/subversion:RUBY_VERSION_REQD=193,PKG_APACHE=apache2,PYTHON_VERSION_REQD=27 |
# normalize_version |
# cmp 'pkg_src_summary #24.1' \
# 'ASSIGNMENTS=PKG_APACHE=apache2
# PKGNAME=subversion-X
# PKGPATH=devel/subversion

# '

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=193 |
normalize_version |
cmp 'pkg_src_summary #23.4' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=subversion-X
PKGPATH=devel/subversion

'

pkg_src_summary -m -f PKGNAME,PKGPATH \
    devel/subversion:RUBY_VERSION_REQD=193,PKG_APACHE=apache2 |
normalize_version |
cmp 'pkg_src_summary #23.3' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2,PYTHON_VERSION_REQD=26
PKGNAME=subversion-X
PKGPATH=devel/subversion

'

pkg_src_summary -m -f PKGNAME,PKGPATH devel/subversion:PKG_APACHE=apache2 |
normalize_version |
cmp 'pkg_src_summary #23.2' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2,PYTHON_VERSION_REQD=26
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

'

pkg_src_summary -m -f PKGNAME,PKGPATH devel/subversion |
normalize_version |
cmp 'pkg_src_summary #23.1' \
'ASSIGNMENTS=PKG_APACHE=apache13
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache13,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache13,PYTHON_VERSION_REQD=26
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache13,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2,PYTHON_VERSION_REQD=26
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache2,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PYTHON_VERSION_REQD=26
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache24
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache24,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache24,PYTHON_VERSION_REQD=26
PKGNAME=subversion-X
PKGPATH=devel/subversion

ASSIGNMENTS=PKG_APACHE=apache24,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
PKGNAME=subversion-X
PKGPATH=devel/subversion

'

pkg_src_summary -m -f PKGNAME,PKGPATH www/ap-php:PKG_APACHE=apache2,PHP_VERSION_REQD=53 |
normalize_version |
cmp 'pkg_src_summary #22.3' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=ap2-php53-X
PKGPATH=www/ap-php

'

pkg_src_summary -m -f PKGNAME,PKGPATH www/ap-php:PKG_APACHE=apache2 |
normalize_version |
cmp 'pkg_src_summary #22.2' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=ap2-php53-X
PKGPATH=www/ap-php

ASSIGNMENTS=PKG_APACHE=apache2,PHP_VERSION_REQD=54
PKGNAME=ap2-php54-X
PKGPATH=www/ap-php

'

pkg_src_summary -m -f PKGNAME,PKGPATH www/ap-php |
normalize_version |
cmp 'pkg_src_summary #22.1' \
'ASSIGNMENTS=PKG_APACHE=apache13
PKGNAME=ap13-php53-X
PKGPATH=www/ap-php

ASSIGNMENTS=PKG_APACHE=apache13,PHP_VERSION_REQD=54
PKGNAME=ap13-php54-X
PKGPATH=www/ap-php

ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=ap2-php53-X
PKGPATH=www/ap-php

ASSIGNMENTS=PKG_APACHE=apache2,PHP_VERSION_REQD=54
PKGNAME=ap2-php54-X
PKGPATH=www/ap-php

PKGNAME=ap22-php53-X
PKGPATH=www/ap-php

ASSIGNMENTS=PHP_VERSION_REQD=54
PKGNAME=ap22-php54-X
PKGPATH=www/ap-php

ASSIGNMENTS=PKG_APACHE=apache24
PKGNAME=ap24-php53-X
PKGPATH=www/ap-php

ASSIGNMENTS=PKG_APACHE=apache24,PHP_VERSION_REQD=54
PKGNAME=ap24-php54-X
PKGPATH=www/ap-php

'

pkg_src_summary -A -f PKGNAME,PKGPATH lang/ruby18 > "$tmpfn1"
pkg_summary2deps -pnrA2 "$tmpfn1" 2>&1 > /dev/null |
cmp 'pkg_src_summary #21' \
''

pkg_src_summary -f PKGNAME,PLIST devel/bmake x11/xxkb |
normalize_version |
cmp 'pkg_src_summary #20.1' \
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
normalize_version |
cmp 'pkg_src_summary #1' \
'PKGNAME=dictem-X
PKGPATH=textproc/dictem

PKGNAME=checkperms-X
PKGPATH=sysutils/checkperms

PKGNAME=dict-client-X
PKGPATH=textproc/dict-client

PKGNAME=libmaa-X
PKGPATH=devel/libmaa

PKGNAME=gmake-X
PKGPATH=devel/gmake

PKGNAME=libtool-base-X
PKGPATH=devel/libtool-base

PKGNAME=emacs-X
PKGPATH=editors/emacs

PKGNAME=pkg_summary-utils-X
PKGPATH=wip/pkg_summary-utils

PKGNAME=libungif-X
PKGPATH=graphics/libungif

PKGNAME=tiff-X
PKGPATH=graphics/tiff

PKGNAME=x11-links-X
PKGPATH=pkgtools/x11-links

PKGNAME=perl-X
PKGPATH=lang/perl5

PKGNAME=libltdl-X
PKGPATH=devel/libltdl

PKGNAME=pipestatus-X
PKGPATH=devel/pipestatus

PKGNAME=png-X
PKGPATH=graphics/png

PKGNAME=netcat-X
PKGPATH=net/netcat

PKGNAME=pkg-config-X
PKGPATH=devel/pkg-config

PKGNAME=jpeg-X
PKGPATH=graphics/jpeg

PKGNAME=ap22-vhost-ldap-X
PKGPATH=www/ap22-vhost-ldap

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
Bad package wip/pkg_online-client, skipped
 ------------------
Bad package wip/paexec, skipped
 ------------------
Bad package wip/runawk, skipped
 ------------------
Bad package wip/dict-client, skipped
 ------------------
Bad package wip/awk-pkgsrc-dewey, skipped
 ------------------
Bad package www/ap2-vhost-ldap:PKG_APACHE=apache2, skipped
"

pkg_src_summary -m -fPKGNAME,PKGPATH www/ap2-python |
grep -v DEPENDS |
cmp 'pkg_src_summary #2' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=ap2-py27-python-3.3.1
PKGPATH=www/ap2-python

ASSIGNMENTS=PKG_APACHE=apache2,PYTHON_VERSION_REQD=26
PKGNAME=ap2-py26-python-3.3.1
PKGPATH=www/ap2-python

PKGNAME=ap22-py27-python-3.3.1
PKGPATH=www/ap2-python

ASSIGNMENTS=PYTHON_VERSION_REQD=26
PKGNAME=ap22-py26-python-3.3.1
PKGPATH=www/ap2-python

'

pkg_src_summary -m --fields PKGNAME,PKGPATH www/ap2-python:PKG_APACHE=apache2 |
grep -v DEPENDS |
cmp 'pkg_src_summary #3' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=ap2-py27-python-3.3.1
PKGPATH=www/ap2-python

ASSIGNMENTS=PKG_APACHE=apache2,PYTHON_VERSION_REQD=26
PKGNAME=ap2-py26-python-3.3.1
PKGPATH=www/ap2-python

'

pkg_src_summary -m --fields PKGNAME,PKGPATH www/ap2-python:PKG_APACHE=apache22 |
grep -v DEPENDS |
cmp 'pkg_src_summary #3.1' \
'PKGNAME=ap22-py27-python-3.3.1
PKGPATH=www/ap2-python

ASSIGNMENTS=PYTHON_VERSION_REQD=26
PKGNAME=ap22-py26-python-3.3.1
PKGPATH=www/ap2-python

'

pkg_src_summary -m --fields='PKGNAME PKGPATH' www/ap2-python:PYTHON_VERSION_REQD=27 |
grep -v DEPENDS |
cmp 'pkg_src_summary #4' \
'ASSIGNMENTS=PKG_APACHE=apache2
PKGNAME=ap2-py27-python-3.3.1
PKGPATH=www/ap2-python

PKGNAME=ap22-py27-python-3.3.1
PKGPATH=www/ap2-python

'

pkg_src_summary -m --fields='PKGNAME PKGPATH' www/ap2-python:PYTHON_VERSION_REQD=26 |
grep -v DEPENDS |
cmp 'pkg_src_summary #4.1' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=26,PKG_APACHE=apache2
PKGNAME=ap2-py26-python-3.3.1
PKGPATH=www/ap2-python

ASSIGNMENTS=PYTHON_VERSION_REQD=26
PKGNAME=ap22-py26-python-3.3.1
PKGPATH=www/ap2-python

'

pkg_src_summary -m -f'PKGNAME PKGPATH' \
   www/ap2-python:PYTHON_VERSION_REQD=26,PKG_APACHE=apache22 |
grep -v DEPENDS |
cmp 'pkg_src_summary #5' \
'ASSIGNMENTS=PYTHON_VERSION_REQD=26
PKGNAME=ap22-py26-python-3.3.1
PKGPATH=www/ap2-python

'

pkg_src_summary -Af PKGNAME,PKGPATH \
   graphics/py-cairo:PYTHON_VERSION_REQD=26 |
pkg_grep_summary -s PKGBASE 'python26' |
awk -F= '$1 !~ /DEPENDS/' |
normalize_version |
cmp 'pkg_src_summary #6' \
'PKGNAME=python26-X
PKGPATH=lang/python26

'

pkg_src_summary -A -fPKGNAME,PKGPATH \
   graphics/py-cairo:PYTHON_VERSION_REQD=26 |
pkg_grep_summary -s PKGBASE 'python26' |
awk -F= '$1 !~ /DEPENDS/' |
normalize_version |
cmp 'pkg_src_summary #7' \
'PKGNAME=python26-X
PKGPATH=lang/python26

'

pkg_src_summary -mA -f PKGNAME,PKGPATH graphics/py-cairo |
pkg_grep_summary -m PKGPATH '/python|cairo' |
awk -F= '$1 !~ /DEPENDS/' |
normalize_version |
cmp 'pkg_src_summary #8' \
'PKGNAME=py27-cairo-X
PKGPATH=graphics/py-cairo

ASSIGNMENTS=PYTHON_VERSION_REQD=26
PKGNAME=py26-cairo-X
PKGPATH=graphics/py-cairo

PKGNAME=cairo-X
PKGPATH=graphics/cairo

PKGNAME=python26-X
PKGPATH=lang/python26

PKGNAME=python27-X
PKGPATH=lang/python27

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

hide_distfile_size (){
    sed 's/:[0-9]*/:NNN/g' "$@"
}

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

