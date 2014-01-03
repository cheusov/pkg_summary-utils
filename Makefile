PROJECTNAME =	pkg_summary-utils
BIRTHDATE   =	2008-04-06

SUBPRJ      =	scripts:tests doc
SUBPRJ_DFLT =	scripts

SHRTOUT     =	yes

MKC-REQD    =	0.24.0

NODEPS      =	*:test-tests

test : all-tests test-tests
	@:

############################################################

.include <mkc.subprj.mk>
