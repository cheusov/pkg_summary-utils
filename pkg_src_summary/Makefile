SCRIPTS         =	pkg_src_summary
MAN            +=	pkg_src_summary.1
LIBEXECSCRIPTS +=	get_processed_pkgs direct_deps

INSCRIPTS      +=	pkg_src_summary ${LIBEXECSCRIPTS}

FILES          +=	pkg_src_summary.mk
FILESDIR_pkg_src_summary.mk =	${MKSCRIPTSDIR}

.for i in ${LIBEXECSCRIPTS}
SCRIPTSDIR_${i} =	${LIBEXECDIR}
SCRIPTS        +=	${i}
.endfor

.include "../tests/test.mk"
.include <mkc.mk>
