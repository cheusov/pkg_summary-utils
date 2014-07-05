PROJECTNAME =	pkg_summary-utils
BIRTHDATE   =	2008-04-06

SUBPRJ_DFLT =	scripts grep_summary
SUBPRJ =	${SUBPRJ_DFLT} doc scripts:tests

SHRTOUT     =	yes

MKC_REQD    =	0.26.0

NODEPS      =	*:test-tests

test : all-tests test-tests
	@:

############################################################

.include <mkc.subprj.mk>
