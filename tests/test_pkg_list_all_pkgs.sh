: ${PKGSRCDIR:=/usr/pkgsrc}

if ! test -d PKGSRCDIR; then
    echo "Directory $PKGSRCDIR does not exit, skipping tests for pkg_list_all_pkgs" 1>&2
else

# pkg_list_all_pkgs
env  pkg_list_all_pkgs |
awk '
END {
    if (NR > 7000) {
        print "XXXX"
    }else{
        print "failure"
    }
}' |
cmp 'pkg_list_all_pkgs #1' \
'XXXX
'

# pkg_list_all_pkgs -a
env  pkg_list_all_pkgs -a devel |
awk '
/^devel/ {
    ++cnt
    next
}
END {
    if (cnt > 10 && cnt != NR) {
        print "XXXX"
    }else{
        print "failure"
    }
}' |
cmp 'pkg_list_all_pkgs -a #2' \
'XXXX
'

# pkg_list_all_pkgs -d
env  pkg_list_all_pkgs -d devel |
awk '
/^devel/ {
    ++cnt
}
END {
    if (cnt > 10 && cnt == NR) {
        print "XXXX"
    }else{
        print "failure"
    }
}' |
cmp 'pkg_list_all_pkgs -d #3' \
'XXXX
'

fi
