pkg_cksum2summary -c sha512_summary1X.txt bin_summary1*.txt |
grep -E '^(PKGNAME|PKGPATH|FILE_CKSUM|FILE_NAME)=|^$' |
cmp 'pkg_cksum2summary #1' \
'PKGNAME=distbb-0.33.0
PKGPATH=wip/distbb
FILE_CKSUM=sha512 1a8686f547ffd73a9bb01347c9773fb01cbe403625fb76ddd78f4e6dc4d7311ccfb84a7d299d3eb95f078012f7ec94415a8d55787dde0dc50ff2161b544f89c5

PKGNAME=pkg_online-0.9.1
PKGPATH=wip/pkg_online

PKGNAME=pkg_conflicts-0.4.0
PKGPATH=wip/pkg_conflicts

PKGNAME=checkperms-1.10
PKGPATH=sysutils/checkperms

PKGNAME=libtool-base-1.5.26nb2
PKGPATH=devel/libtool-base

PKGNAME=gmake-3.81
PKGPATH=devel/gmake

PKGNAME=netcat-1.10nb2
PKGPATH=net/netcat

PKGNAME=awk-pkgsrc-dewey-0.5.6
PKGPATH=wip/awk-pkgsrc-dewey

PKGNAME=libmaa-1.1.0
PKGPATH=devel/libmaa

PKGNAME=pkgnih-0.3.1
PKGPATH=wip/pkgnih

PKGNAME=dict-client-1.11.2
PKGPATH=wip/dict-client

PKGNAME=dict-server-1.11.2
PKGPATH=wip/dict-server

PKGNAME=pkg_summary-utils-0.35rc1
PKGPATH=wip/pkg_summary-utils

PKGNAME=pipestatus-0.6.0
PKGPATH=devel/pipestatus

PKGNAME=runawk-0.18.0
PKGPATH=wip/runawk

PKGNAME=paexec-0.13.0nb1
PKGPATH=wip/paexec

PKGNAME=pkg_online-client-0.9.1
PKGPATH=wip/pkg_online-client

PKGNAME=pkg_online-server-0.9.1
PKGPATH=wip/pkg_online-server

PKGNAME=vim-7.2.446nb1
PKGPATH=editors/vim
FILE_NAME=vim-7.2.446nb1.tgz

PKGNAME=vim-xaw-7.2.446nb1
PKGPATH=editors/vim-xaw
FILE_NAME=vim-xaw-7.2.446nb1.tgz

PKGNAME=pidgin-2.10.3
PKGPATH=chat/pidgin

PKGNAME=farsight2-0.0.26nb6
PKGPATH=multimedia/farsight2
FILE_NAME=farsight2-0.0.26nb6.tgz
FILE_CKSUM=sha512 2cded0193eb11db66a067e55694ba3914a86b46fdb081820be0920012f2b3b914b4e905a2223ba305314a714ff8497182dcbec0024b94c9ad8e80bf7823a2e24

PKGNAME=py27-gtk2-2.24.0nb4
PKGPATH=x11/py-gtk2

PKGNAME=py26-gtk2-2.24.0nb4
PKGPATH=x11/py-gtk2
FILE_NAME=py26-gtk2-2.24.0nb4.tgz
FILE_CKSUM=sha512 68359b962b64fb50c47e567e246f3d318fb3ece47e14baf0f8ac267b8414525896145ae5682ceed0a15da59e6fa6c9ddcbc8b733714301e6f0451ac7eab991ee

PKGNAME=gcc48-cc++-4.8.3
PKGPATH=lang/gcc48-cc++
FILE_NAME=gcc48-cc++-4.8.3.tgz
FILE_CKSUM=sha512 16c8387769893cbf82ae2b07d2fe7cb0b422fccbbffa80b19cfb6582685bc3c1ff95d7791a87f3453da0aa76a102b269f96ddd641be5c81b1ee25b5aeef23021

PKGNAME=webkit-gtk-2.4.5
PKGPATH=www/webkit-gtk
FILE_NAME=webkit-gtk-2.4.5.tgz

PKGNAME=gcc48-libs-4.8.3
PKGPATH=lang/gcc48-libs
FILE_NAME=gcc48-libs-4.8.3.tgz
FILE_CKSUM=sha512 6fd33a4f3902db029745df17d1ab6693bf5e8cd23d75b98d389dc184e584a85dc3445a3b0aed2687ce57926b2ad463627fd37b1b2e11db83fcad77c3f3bdf22a

'
