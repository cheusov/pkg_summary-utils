VERSION     =	0.70.0

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

###
INTEXTS_REPLS +=	version      ${VERSION}
INTEXTS_REPLS +=	awkmoddir    ${AWKMODDIR}
INTEXTS_REPLS +=	mkscriptsdir ${MKSCRIPTSDIR}
INTEXTS_REPLS +=	SH           ${SH}
INTEXTS_REPLS +=	AWK          ${AWK}
INTEXTS_REPLS +=	DISTDIR      ${DISTDIR}
INTEXTS_REPLS +=	PKGSRCDIR    ${PKGSRCDIR}
INTEXTS_REPLS +=	BMAKE        ${BMAKE}
INTEXTS_REPLS +=	PKG_SUFX     ${PKG_SUFX}
INTEXTS_REPLS +=	PKG_DBDIR    ${PKG_DBDIR}

INTEXTS_SED += -e 's,@PKG_INFO_CMD@,${PKG_INFO_CMD},'

# NetBSD make is required for pkgsrc
BMAKE        ?=	bmake
