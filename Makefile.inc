VERSION     =	0.65.2

MKC_FEATURES        =	strlcat strlcpy getline

LIBEXECDIR ?=	${PREFIX}/libexec/psu
DOCDIR     ?=	${DATADIR}/doc/pkg_summary-utils
EGDIR      ?=	${DOCDIR}/examples
AWKMODDIR  ?=	${DATADIR}/runawk
MKSCRIPTSDIR ?=	${DATADIR}/psu_mk
DISTDIR    ?=	/usr/pkgsrc/distfiles
PKGSRCDIR  ?=	/usr/pkgsrc
PKG_SUFX   ?=	.tgz
PKG_DBDIR  ?=	/var/db/pkg
PKG_TOOLS_BIN ?=/usr/sbin
DIFF_PROG  ?=	diff -U10

COPTS        ?=	-O3 -g

SH           ?=	/bin/sh
AWK          ?=	/usr/bin/awk
PKG_INFO_CMD ?=	${PKG_TOOLS_BIN}/pkg_info -K ${PKG_DBDIR}

# NetBSD make is required for pkgsrc
BMAKE        ?=	bmake
