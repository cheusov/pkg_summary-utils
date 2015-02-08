#############################################################

LIBEXECSCRIPTS =	direct_deps XB2bin_summary get_processed_pkgs \
	summary2multi_variants enrich_summary

INSCRIPTS  =	${LIBEXECSCRIPTS}
INSCRIPTS +=	pkg_cmp_summary pkg_list_all_pkgs
INSCRIPTS +=	pkg_refresh_summary pkg_src_fetch_var
INSCRIPTS +=	pkg_micro_src_summary pkg_src_summary
INSCRIPTS +=	pkg_update_src_summary pkg_summary4view
INSCRIPTS +=	pkg_update_summary pkg_grep_summary
INSCRIPTS +=	cvs_checksum pkg_assignments2pkgpath
INSCRIPTS +=	pkg_uniq_summary pkg_summary2bb_pkgs
INSCRIPTS +=	pkg_cleanup_distdir pkg_summary2build_graph
INSCRIPTS +=	pkg_summary2deps pkg_lint_summary
INSCRIPTS +=	pkg_subgraph_deps pkg_bin_summary
INSCRIPTS +=	pkg_digger_summary pkg_digger_installed pkg_digger
INSCRIPTS +=	makefiles2deps pkg_summary2leaves pkg_cksum2summary

SCRIPTS    =	${INSCRIPTS}

.for i in ${LIBEXECSCRIPTS}
SCRIPTSDIR_${i} =	${LIBEXECDIR}
.endfor

MAN  =		pkg_summary-utils.7
MAN +=		pkg_cmp_summary.1 pkg_list_all_pkgs.1
MAN +=		pkg_refresh_summary.1
MAN +=		pkg_micro_src_summary.1 pkg_src_summary.1
MAN +=		pkg_update_src_summary.1 pkg_summary4view.1
MAN +=		pkg_update_summary.1 pkg_grep_summary.1
MAN +=		cvs_checksum.1 # pkg_assignments2pkgpath.1
MAN +=		pkg_uniq_summary.1 # pkg_summary2bb_pkgs.1
MAN +=		pkg_cleanup_distdir.1 pkg_summary2build_graph.1
MAN +=		pkg_summary2deps.1 pkg_lint_summary.1
MAN +=		pkg_subgraph_deps.1 pkg_bin_summary.1
MAN +=		pkg_digger_summary.1 pkg_digger_installed.1 pkg_digger.1
MAN +=		makefiles2deps.1 pkg_summary2leaves.1 pkg_cksum2summary.1

FILES  =	pkg_grep_summary.awk pkg_src_summary.mk psu_funcs.awk
FILES +=	pkgsrc-dewey.awk pkg_digger.conf
FILES +=	sig_handler.sh

FILESDIR                    =	${AWKMODDIR}
FILESDIR_pkg_src_summary.mk =	${MKSCRIPTSDIR}
FILESDIR_pkg_digger.conf    =	${EGDIR}
FILESDIR_sig_handler.sh     =	${LIBEXECDIR}

SYMLINKS  =	pkg_digger_summary ${BINDIR}/pkg_digger_backend

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

############################################################

.include <mkc.prog.mk>
