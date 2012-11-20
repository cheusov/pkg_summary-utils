# pkg_summary4view
pkg_summary2bb_pkgs src_summary18.txt |
cmp 'pkg_summary2bb_pkgs #1' \
'PKGNAME=py27-qutrub-0.5
PKGPATH=wip/py-qutrub

ASSIGNMENTS=PYTHON_VERSION_REQD=26
PKGNAME=py26-qutrub-0.5
PKGPATH=wip/py-qutrub

'

pkg_summary2bb_pkgs 2>&1 |
cmp 'pkg_summary2bb_pkgs failure #2' \
'At least one file is expected as an argument
'
