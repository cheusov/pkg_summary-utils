grep_pss_stderr (){
    grep -E 'Bad package| ----------' "$@"
}

# 1
input_data1 (){
    cat <<'EOF'
PKGNAME=ap22-php54-5.4.7
PKGPATH=www/ap-php
_VARIANTS=PKG_APACHE=apache13,apache2,apache22,apache24 PHP_VERSION_REQD=53,54
_INHER_ASSIGNS=
_INHER_ASSIGNS_REJ=
ASSIGNMENTS=

EOF
}

input_data1 | summary2multi_variants |
cmp 'summary2multi_variants #1' \
'www/ap-php:PKG_APACHE=apache13,PHP_VERSION_REQD=53
www/ap-php:PKG_APACHE=apache13,PHP_VERSION_REQD=54
www/ap-php:PKG_APACHE=apache2,PHP_VERSION_REQD=53
www/ap-php:PKG_APACHE=apache2,PHP_VERSION_REQD=54
www/ap-php:PKG_APACHE=apache22,PHP_VERSION_REQD=53
www/ap-php:PKG_APACHE=apache22,PHP_VERSION_REQD=54
www/ap-php:PKG_APACHE=apache24,PHP_VERSION_REQD=53
www/ap-php:PKG_APACHE=apache24,PHP_VERSION_REQD=54
'

# 2
input_data2 (){
cat <<EOF
PKGNAME=ap2-php54-5.4.7
PKGPATH=www/ap-php
_VARIANTS=PHP_VERSION_REQD=53,54
_INHER_ASSIGNS=PKG_APACHE=apache2
_INHER_ASSIGNS_REJ=
PHP_VERSIONS_ACCEPTED=53 54
ASSIGNMENTS=PKG_APACHE=apache2

EOF
}

input_data2 | summary2multi_variants |
cmp 'summary2multi_variants #2' \
'www/ap-php:PKG_APACHE=apache2,PHP_VERSION_REQD=53
www/ap-php:PKG_APACHE=apache2,PHP_VERSION_REQD=54
'

# 3
input_data3 (){
    cat <<'EOF'
PKGNAME=ap2-php53-5.3.17
PKGPATH=www/ap-php
_VARIANTS=
_INHER_ASSIGNS=PKG_APACHE=apache2
_INHER_ASSIGNS_REJ=PHP_VERSION_REQD=53
PHP_VERSIONS_ACCEPTED=53 54
ASSIGNMENTS=PKG_APACHE=apache2

EOF
}

input_data3 | summary2multi_variants |
cmp 'summary2multi_variants #3' \
''

# 4
input_data4 (){
    cat <<'EOF'
PKGNAME=subversion-1.6.17
PKGPATH=devel/subversion
_VARIANTS=PKG_APACHE=apache13,apache2,apache22,apache24 PYTHON_VERSION_REQD=27,26 RUBY_VERSION_REQD=193,18
_INHER_ASSIGNS=
_INHER_ASSIGNS_REJ=
PHP_VERSIONS_ACCEPTED=

EOF
}

input_data4 | summary2multi_variants |
cmp 'summary2multi_variants #4' \
'devel/subversion:PKG_APACHE=apache13,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache13,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache13,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache13,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache22,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache22,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache22,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache22,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache24,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache24,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache24,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache24,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
'

# 5
input_data5 (){
    cat <<'EOF'
PKGNAME=subversion-1.6.17
PKGPATH=devel/subversion
_VARIANTS=PYTHON_VERSION_REQD=27,26 RUBY_VERSION_REQD=193,18
_INHER_ASSIGNS=PKG_APACHE=apache2
_INHER_ASSIGNS_REJ=
PHP_VERSIONS_ACCEPTED=
ASSIGNMENTS=PKG_APACHE=apache2

EOF
}

input_data5 | summary2multi_variants |
cmp 'summary2multi_variants #5' \
'devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=27,RUBY_VERSION_REQD=18
devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=193
devel/subversion:PKG_APACHE=apache2,PYTHON_VERSION_REQD=26,RUBY_VERSION_REQD=18
'

# 6
input_data6 (){
    cat <<'EOF'
PKGNAME=subversion-1.6.17
PKGPATH=devel/subversion
_VARIANTS=PYTHON_VERSION_REQD=27,26
_INHER_ASSIGNS=PKG_APACHE=apache2
_INHER_ASSIGNS_REJ=RUBY_VERSION_REQD=193
PHP_VERSIONS_ACCEPTED=
ASSIGNMENTS=PKG_APACHE=apache2

EOF
}

input_data6 | summary2multi_variants |
cmp 'summary2multi_variants #6' \
'devel/subversion:PKG_APACHE=apache2,RUBY_VERSION_REQD=193,PYTHON_VERSION_REQD=27
devel/subversion:PKG_APACHE=apache2,RUBY_VERSION_REQD=193,PYTHON_VERSION_REQD=26
'


# 7
input_data7 (){
    cat <<'EOF'
PKGNAME=subversion-1.6.17
PKGPATH=devel/subversion
_VARIANTS=
_INHER_ASSIGNS=PKG_APACHE=apache2
_INHER_ASSIGNS_REJ=RUBY_VERSION_REQD=193,PYTHON_VERSION_REQD=27
PHP_VERSIONS_ACCEPTED=
ASSIGNMENTS=PKG_APACHE=apache2
EOF
}

input_data7 | summary2multi_variants |
cmp 'summary2multi_variants #7' \
''
