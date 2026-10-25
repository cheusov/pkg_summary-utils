INSCRIPTS +=	pkg_cmp_summary
MAN       +=	pkg_cmp_summary.1

test_output: .PHONY
test_output:
	@PATH=${OBJDIR}:$$PATH; export PATH; \
	AWKPATH="../scripts:${OBJDIR_scripts}"; export AWKPATH; \
	\
	echo 'pkg_cmp_summary   #1'; \
	pkg_cmp_summary ../tests/src_summary.txt ../tests/src_summary2.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -e   #1.1'; \
	pkg_cmp_summary -e ../tests/src_summary.txt ../tests/src_summary2.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -p   #2'; \
	pkg_cmp_summary -p ../tests/src_summary.txt ../tests/src_summary2.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -fpba    #2.1'; \
	pkg_cmp_summary -fpba ../tests/src_summary.txt ../tests/src_summary2.txt | sort -k2,2; \
	echo 'pkg_cmp_summary      #4'; \
	pkg_cmp_summary ../tests/src_summary4.txt ../tests/src_summary5.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -p   #5'; \
	pkg_cmp_summary -p ../tests/src_summary4.txt ../tests/src_summary5.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -c   #7'; \
	pkg_cmp_summary -c ../tests/src_summary4.txt ../tests/src_summary5.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -cp  #8'; \
	pkg_cmp_summary -cp ../tests/src_summary4.txt ../tests/src_summary6.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -f ap   #9'; \
	pkg_cmp_summary -P ../tests/src_summary.txt ../tests/src_summary2.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -fpa  #9.1'; \
	pkg_cmp_summary -fpa ../tests/src_summary.txt ../tests/src_summary2.txt | sort -k2,2; \
	echo 'pkg_cmp_summary -d   #11'; \
	pkg_cmp_summary -d ../tests/summary1.txt ../tests/summary2.txt; \
	echo 'pkg_cmp_summary -d   #12'; \
	pkg_cmp_summary -d ../tests/summary2.txt ../tests/summary1.txt; \
	echo 'pkg_cmp_summary -d   #13'; \
	pkg_cmp_summary -d ../tests/summary1.txt ../tests/summary4.txt; \
	echo 'pkg_cmp_summary -d   #14'; \
	pkg_cmp_summary -d ../tests/summary4.txt ../tests/summary1.txt; \
	echo 'pkg_cmp_summary -d   #15'; \
	pkg_cmp_summary -d ../tests/summary1.txt ../tests/summary3.txt; \
	echo 'pkg_cmp_summary -d   #16'; \
	pkg_cmp_summary -d ../tests/summary3.txt ../tests/summary1.txt; \
	echo 'pkg_cmp_summary -pe2 #17.1'; \
	pkg_cmp_summary -pe2 ../tests/src_summary14.txt ../tests/bin_summary3.txt | sort; \
	echo 'pkg_cmp_summary -pe  #17.2'; \
	pkg_cmp_summary -pe ../tests/src_summary14.txt ../tests/bin_summary3.txt | sort; \
	echo 'pkg_cmp_summary -p   #17.3'; \
	pkg_cmp_summary -p ../tests/src_summary14.txt ../tests/bin_summary3.txt | sort; \
	echo 'pkg_cmp_summary -pe2 #17.4'; \
	pkg_cmp_summary -pe2 ../tests/src_summary14.txt - < ../tests/src_summary14.txt | sort; \
	echo 'pkg_cmp_summary      #17.5'; \
	pkg_cmp_summary -pe2 ../tests/bin_summary3.txt - < ../tests/bin_summary3.txt | sort; \
	echo 'pkg_cmp_summary -pu  #18.1'; \
	pkg_cmp_summary -pu ../tests/bin_summary2.txt - < ../tests/bin_summary3.txt | sort; \
	echo 'pkg_cmp_summary -pb  #18.2'; \
	pkg_cmp_summary -pb ../tests/bin_summary1.txt ../tests/bin_summary2.txt | sort; \
	echo 'pkg_cmp_summary -a   #19.1'; \
	pkg_cmp_summary -a automatic,try_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -Ea  #19.2'; \
	pkg_cmp_summary -a automatic,try_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -A   #20.1'; \
	pkg_cmp_summary -A automatic,try_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -Aa  #20.2'; \
	pkg_cmp_summary -a automatic -A try_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -Aa  #20.3'; \
	pkg_cmp_summary -A automatic -atry_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -AE  #20.4'; \
	pkg_cmp_summary -A automatic,try_out -E ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -AaE  #20.5'; \
	pkg_cmp_summary -Ea automatic -A try_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -AaE  #20.6'; \
	pkg_cmp_summary -EA automatic -atry_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -O  #20.7'; \
	pkg_cmp_summary -O automatic,try_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -Oa  #20.8'; \
	pkg_cmp_summary -a automatic -O try_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -Oa  #20.9'; \
	pkg_cmp_summary -O automatic -atry_out ../tests/bin_summary91.txt ../tests/bin_summary92.txt; \
	echo 'pkg_cmp_summary -A  #21.1'; \
	pkg_cmp_summary -A sec ../tests/src_summary21.txt ../tests/src_summary22.txt | LC_ALL=C sort; \
	echo 'pkg_cmp_summary -O  #21.2'; \
	pkg_cmp_summary -O ret ../tests/src_summary21.txt ../tests/src_summary22.txt | LC_ALL=C sort

.include <mkc.minitest.mk>
.include <mkc.mk>
