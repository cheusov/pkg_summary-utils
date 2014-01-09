VERSION     =	0.62.0

MKC_COMMON_HEADERS  =	string.h
MKC_SOURCE_FUNCLIBS =	strlcat strlcpy
MKC_CHECK_FUNCS3    =	strlcat strlcpy

LIBEXECDIR ?=	${PREFIX}/libexec/psu
DOCDIR     ?=	${DATADIR}/doc/pkg_summary-utils
EGDIR      ?=	${DOCDIR}/examples
AWKMODDIR  ?=	${DATADIR}/runawk
MKSCRIPTSDIR ?=	${DATADIR}/psu_mk
DISTDIR    ?=	/usr/pkgsrc/distfiles
PKGSRCDIR  ?=	/usr/pkgsrc
PKG_SUFX   ?=	.tgz
PKG_DBDIR  ?=	/var/db/pkg
DIFF_PROG  ?=	diff -U10

SH           ?=	/bin/sh
AWK          ?=	/usr/bin/awk
PKG_INFO_CMD ?=	/usr/sbin/pkg_info -K ${PKG_DBDIR}

# NetBSD make is required for pkgsrc
BMAKE        ?=	/usr/bin/make
