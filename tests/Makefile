test:
	@echo 'running tests...'; \
	unset MAKEFLAGS; \
	set -e; \
	OBJDIR=${OBJDIR_scripts}; export OBJDIR; \
	env PATH="$OBJDIR:$$PATH" ${SH} ./test.sh

.include <mkc.mk>

.export PREFIX
.export BMAKE
.export PKGSRCDIR
.export OBJDIR_scripts
.export OBJDIR_grep_summary
