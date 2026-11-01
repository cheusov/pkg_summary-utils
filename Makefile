PROJECTNAME =	pkg_summary-utils
BIRTHDATE   =	2008-04-06

SUBPRJ_DFLT =	man7 pkg_cmp_summary pkg_cksum2summary pkg_list_all_pkgs \
		pkg_refresh_summary pkg_src_fetch_var \
		pkg_micro_src_summary pkg_src_summary \
		pkg_update_src_summary pkg_summary4view \
		pkg_update_summary pkg_grep_summary \
		pkg_assignments2pkgpath \
		pkg_uniq_summary pkg_summary2bb_pkgs \
		pkg_cleanup_dir pkg_cleanup_distdir pkg_cleanup_packages \
		pkg_summary2build_graph \
		pkg_summary2deps pkg_lint_summary \
		pkg_subgraph_deps pkg_bin_summary XB2bin_summary \
		pkg_digger_summary pkg_digger_installed pkg_digger \
		pkg_summary2leaves makefiles2deps summary2multi_variants \
		pkg_enrich_summary pkgsrc_dewey cvs_checksum rpmdb2summary

SUBPRJ =	${SUBPRJ_DFLT} doc pkg_grep_summary:pkg_digger_summary \
	common:pkg_refresh_summary common:pkg_list_all_pkgs

SHRTOUT     =	yes

MKC_REQD    =	0.26.0

test-pkg_digger: pkg_digger_summary pkg_summary4view
test-pkg_digger_installed: XB2bin_summary common pkg_bin_summary pkg_digger_summary
test-pkg_cleanup_packages: pkg_cleanup_dir
test-pkg_cleanup_distdir: pkg_cleanup_dir
test-pkg_src_summary: cvs_checksum pkg_grep_summary summary2multi_variants \
   pkg_enrich_summary pkg_uniq_summary pkg_summary2deps
test-pkg_bin_summary: XB2bin_summary pkg_grep_summary
test-pkg_lint_summary: pkg_summary2deps
test-pkg_micro_src_summary: pkg_src_fetch_var pkg_src_summary
test-pkg_refresh_summary: pkg_grep_summary pkg_uniq_summary
test-pkg_summary2leaves: pkg_summary2deps pkg_grep_summary
test-pkg_summary4view: pkg_grep_summary

############################################################
.include "Makefile.inc"
.include <mkc.subprj.mk>
