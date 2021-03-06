# makefiles2deps

echo "`pwd`/makefiles/foo.mk" |
makefiles2deps 2>&1 | sed "s,`pwd`/,,g" |
cmp 'makefiles2deps #1' \
'makefiles/1.mk makefiles/foo.mk
makefiles/2.mk makefiles/foo.mk
makefiles/3.mk makefiles/foo.mk
makefiles/1.mk makefiles/2.mk
'

echo "`pwd`/makefiles/bar.mk" |
makefiles2deps 2>&1 | sed "s,`pwd`/,,g" |
cmp 'makefiles2deps #2' \
'makefiles/1.mk makefiles/bar.mk
makefiles/2.mk makefiles/bar.mk
makefiles/4.mk makefiles/bar.mk
makefiles/1.mk makefiles/2.mk
'

echo "`pwd`/makefiles/baz.mk" |
makefiles2deps 2>&1 | sed "s,`pwd`/,,g" |
cmp 'makefiles2deps #3' \
'makefiles/2.mk makefiles/baz.mk
makefiles/4.mk makefiles/baz.mk
makefiles/5.mk makefiles/baz.mk
makefiles/1.mk makefiles/2.mk
'

print_filenames4 (){
    cat <<EOF
`pwd`/makefiles/1.mk
`pwd`/makefiles/3.mk
`pwd`/makefiles/quux.mk
EOF
}

print_filenames4 | makefiles2deps 2>&1 | sed "s,`pwd`/,,g" |
cmp 'makefiles2deps #4' \
'makefiles/1.mk
makefiles/3.mk
'

echo "`pwd`/makefiles/quux.mk" |
makefiles2deps 2>&1 | sed "s,`pwd`/,,g" |
cmp 'makefiles2deps #5' \
''
