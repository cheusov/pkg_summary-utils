# pkg_subgraph_deps
pkg_subgraph_deps -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #1' \
'textproc/dictem
wip/awk-pkgsrc-dewey wip/pkg_summary-utils
wip/libuxre wip/heirloom-awk
wip/paexec wip/distbb
wip/pkg_summary-utils wip/distbb
wip/pkg_summary-utils wip/pkg_online-client
wip/pkg_summary-utils wip/pkg_online-server
wip/runawk wip/awk-pkgsrc-dewey
wip/runawk wip/distbb
wip/runawk wip/paexec
wip/runawk wip/pkg_summary-utils
'

pkg_subgraph_deps -1 -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #1.1' \
'textproc/dictem
wip/libuxre wip/heirloom-awk
wip/runawk wip/awk-pkgsrc-dewey
wip/runawk wip/distbb
wip/runawk wip/paexec
wip/runawk wip/pkg_summary-utils
'

pkg_subgraph_deps -f src_pkgs.txt -r src_deps.txt | sort |
cmp 'pkg_subgraph_deps #2' \
'devel/libtool-base wip/libuxre
lang/f2c devel/libtool-base
textproc/dictem
wip/heirloom-common wip/heirloom-doc
wip/heirloom-doc wip/heirloom-libcommon
wip/heirloom-libcommon wip/libuxre
wip/runawk
'

pkg_subgraph_deps -1 -f src_pkgs.txt -r src_deps.txt | sort |
cmp 'pkg_subgraph_deps #2.1' \
'devel/libtool-base wip/libuxre
textproc/dictem
wip/heirloom-libcommon wip/libuxre
wip/runawk
'

pkg_subgraph_deps -x -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #3' \
'wip/awk-pkgsrc-dewey wip/pkg_summary-utils
wip/heirloom-awk
wip/paexec wip/distbb
wip/pkg_summary-utils wip/distbb
wip/pkg_summary-utils wip/pkg_online-client
wip/pkg_summary-utils wip/pkg_online-server
'

pkg_subgraph_deps -x1 -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #3.1' \
'wip/awk-pkgsrc-dewey
wip/distbb
wip/heirloom-awk
wip/paexec
wip/pkg_summary-utils
'

pkg_subgraph_deps -rx -fsrc_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #4' \
'lang/f2c devel/libtool-base
wip/heirloom-common wip/heirloom-doc
wip/heirloom-doc wip/heirloom-libcommon
'

pkg_subgraph_deps -1rx -fsrc_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #4.1' \
'devel/libtool-base
wip/heirloom-libcommon
'

pkg_subgraph_deps -xv -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #5' \
'devel/gmake textproc/dict-client
devel/gmake textproc/dict-server
devel/libjudy
devel/libmaa textproc/dict-client
devel/libmaa textproc/dict-server
devel/libtool-base devel/libmaa
devel/libtool-base textproc/dict-client
devel/libtool-base textproc/dict-server
devel/libtool-base wip/libuxre
devel/pipestatus
lang/f2c devel/libtool-base
net/netcat
textproc/dictem
wip/heirloom-common wip/heirloom-doc
wip/heirloom-doc wip/heirloom-libcommon
wip/heirloom-libcommon wip/libuxre
wip/runawk
'

pkg_subgraph_deps -1v -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #5.1' \
'devel/gmake textproc/dict-client
devel/gmake textproc/dict-server
devel/libjudy
devel/libmaa textproc/dict-client
devel/libmaa textproc/dict-server
devel/libmaa wip/paexec
devel/libtool-base devel/libmaa
devel/libtool-base textproc/dict-client
devel/libtool-base textproc/dict-server
devel/libtool-base wip/libuxre
devel/pipestatus wip/distbb
devel/pipestatus wip/pkg_online-client
devel/pipestatus wip/pkg_online-server
devel/pipestatus wip/pkg_summary-utils
lang/f2c devel/libtool-base
net/netcat wip/pkg_online-client
textproc/dict-client wip/pkg_online-client
textproc/dict-server wip/pkg_online-server
wip/awk-pkgsrc-dewey wip/pkg_summary-utils
wip/heirloom-common wip/heirloom-doc
wip/heirloom-doc wip/heirloom-awk
wip/heirloom-doc wip/heirloom-libcommon
wip/heirloom-libcommon wip/heirloom-awk
wip/heirloom-libcommon wip/libuxre
wip/paexec wip/distbb
wip/pkg_summary-utils wip/distbb
wip/pkg_summary-utils wip/pkg_online-client
wip/pkg_summary-utils wip/pkg_online-server
'

pkg_subgraph_deps -xvt -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #6' \
'devel/gmake textproc/dict-client
devel/gmake textproc/dict-server
devel/libjudy devel/libjudy
devel/libmaa textproc/dict-client
devel/libmaa textproc/dict-server
devel/libtool-base devel/libmaa
devel/libtool-base textproc/dict-client
devel/libtool-base textproc/dict-server
devel/libtool-base wip/libuxre
devel/pipestatus devel/pipestatus
lang/f2c devel/libtool-base
net/netcat net/netcat
textproc/dictem textproc/dictem
wip/heirloom-common wip/heirloom-doc
wip/heirloom-doc wip/heirloom-libcommon
wip/heirloom-libcommon wip/libuxre
wip/runawk wip/runawk
'

pkg_subgraph_deps -xvn -f src_pkgs.txt src_deps.txt | sort |
cmp 'pkg_subgraph_deps #7' \
'devel/gmake
devel/libjudy
devel/libmaa
devel/libtool-base
devel/pipestatus
lang/f2c
net/netcat
textproc/dict-client
textproc/dict-server
textproc/dictem
wip/heirloom-common
wip/heirloom-doc
wip/heirloom-libcommon
wip/libuxre
wip/runawk
'

pkg_subgraph_deps -r -p'wip/pkg_online-client,wip/distbb' src_deps.txt |
sort |
cmp 'pkg_subgraph_deps #8' \
''

pkg_subgraph_deps -r -p'wip/pkg_online-client wip/distbb' src_deps.txt |
sort |
cmp 'pkg_subgraph_deps #8.1' \
'devel/gmake textproc/dict-client
devel/libmaa textproc/dict-client
devel/libmaa wip/paexec
devel/libtool-base devel/libmaa
devel/libtool-base textproc/dict-client
devel/pipestatus wip/distbb
devel/pipestatus wip/pkg_online-client
devel/pipestatus wip/pkg_summary-utils
lang/f2c devel/libtool-base
net/netcat wip/pkg_online-client
textproc/dict-client wip/pkg_online-client
wip/awk-pkgsrc-dewey wip/pkg_summary-utils
wip/paexec wip/distbb
wip/pkg_summary-utils wip/distbb
wip/pkg_summary-utils wip/pkg_online-client
wip/runawk wip/awk-pkgsrc-dewey
wip/runawk wip/distbb
wip/runawk wip/paexec
wip/runawk wip/pkg_summary-utils
'

pkg_subgraph_deps -r1 -p'wip/pkg_online-client wip/distbb' src_deps.txt |
sort |
cmp 'pkg_subgraph_deps #8.2' \
'devel/pipestatus wip/distbb
devel/pipestatus wip/pkg_online-client
net/netcat wip/pkg_online-client
textproc/dict-client wip/pkg_online-client
wip/paexec wip/distbb
wip/pkg_summary-utils wip/distbb
wip/pkg_summary-utils wip/pkg_online-client
wip/runawk wip/distbb
'

pkg_subgraph_deps -rtxv1 -p'wip/distbb' src_deps.txt 2>&1 |
head -n1 |
cmp 'pkg_subgraph_deps #9' \
'error: assertion failed: pkg_subgraph_deps: -xv1 is not allowed!
'

pkg_subgraph_deps -r -f src_pkgs2.txt src_deps2.txt |
sort |
cmp 'pkg_subgraph_deps #10' \
'BUILD_DEPENDS devel/gmake textproc/dict-server
BUILD_DEPENDS devel/libtool-base devel/libmaa
BUILD_DEPENDS devel/libtool-base textproc/dict-server
BUILD_DEPENDS devel/libtool-base wip/libuxre
BUILD_DEPENDS lang/perl5 textproc/dict-mueller7
BUILD_DEPENDS sysutils/coreutils textproc/dict-mueller7
BUILD_DEPENDS textproc/dict-server textproc/dict-mueller7
BUILD_DEPENDS wip/heirloom-libcommon wip/libuxre
DEPENDS devel/libmaa textproc/dict-server
DEPENDS lang/f2c devel/libtool-base
DEPENDS textproc/dict-server textproc/dict-mueller7
DEPENDS wip/heirloom-common wip/heirloom-doc
DEPENDS wip/heirloom-doc wip/heirloom-libcommon
textproc/dictem
wip/runawk
'

boost_pkgs='devel/boost-build
devel/boost-docs
devel/boost-headers
devel/boost-jam
devel/boost-libs
devel/boost-python
meta-pkgs/boost
'

pkg_subgraph_deps -1p "$boost_pkgs" src_summary19.txt |
sort |
cmp 'pkg_subgraph_deps #11.1.1' \
'devel/boost-build
devel/boost-docs
devel/boost-headers audio/bmpx
devel/boost-headers audio/mp3diags
devel/boost-headers cad/librecad
devel/boost-headers cad/openscad
devel/boost-headers chat/konversation
devel/boost-headers converters/libvisio
devel/boost-headers databases/libcassandra
devel/boost-headers databases/mysql-workbench
devel/boost-headers devel/boost-libs
devel/boost-headers devel/boost-python
devel/boost-headers devel/kdesdk4
devel/boost-headers devel/kdevelop4
devel/boost-headers devel/kdevplatform
devel/boost-headers devel/libthrift
devel/boost-headers devel/mdds
devel/boost-headers devel/monotone
devel/boost-headers devel/vera++
devel/boost-headers devel/xsd
devel/boost-headers editors/Sigil
devel/boost-headers editors/abiword-plugins
devel/boost-headers games/alephone
devel/boost-headers games/flightgear
devel/boost-headers games/holtz
devel/boost-headers games/pingus
devel/boost-headers games/pokerth
devel/boost-headers games/scummvm-tools
devel/boost-headers games/simgear
devel/boost-headers games/wesnoth
devel/boost-headers geography/merkaartor
devel/boost-headers graphics/aqsis
devel/boost-headers graphics/digikam
devel/boost-headers graphics/enblend-enfuse
devel/boost-headers graphics/exiv2-organize
devel/boost-headers graphics/gource
devel/boost-headers graphics/hugin
devel/boost-headers graphics/inkscape
devel/boost-headers graphics/kipi-plugins
devel/boost-headers graphics/panomatic
devel/boost-headers ham/gnuradio-audio-jack
devel/boost-headers ham/gnuradio-audio-oss
devel/boost-headers ham/gnuradio-audio-portaudio
devel/boost-headers ham/gnuradio-core
devel/boost-headers ham/gnuradio-core-docs
devel/boost-headers ham/gnuradio-examples
devel/boost-headers ham/gnuradio-gsm
devel/boost-headers ham/gnuradio-howto
devel/boost-headers ham/gnuradio-radio-astronomy
devel/boost-headers ham/gnuradio-trellis
devel/boost-headers ham/gnuradio-usrp
devel/boost-headers ham/gnuradio-video-sdl
devel/boost-headers ham/gnuradio-wxgui
devel/boost-headers ham/usrp
devel/boost-headers ham/usrp-docs
devel/boost-headers inputmethod/ibus-pinyin
devel/boost-headers mail/akonadi
devel/boost-headers math/cgal
devel/boost-headers math/fityk
devel/boost-headers math/xylib
devel/boost-headers misc/kdeadmin4
devel/boost-headers misc/kdepim-runtime4
devel/boost-headers misc/kdepim4
devel/boost-headers misc/kdepimlibs4
devel/boost-headers misc/kdeplasma-addons4
devel/boost-headers misc/libreoffice
devel/boost-headers misc/rocs
devel/boost-headers misc/tellico
devel/boost-headers multimedia/gnash
devel/boost-headers multimedia/mkvtoolnix
devel/boost-headers multimedia/mkvtoolnix-old
devel/boost-headers net/kdenetwork4
devel/boost-headers net/ktorrent
devel/boost-headers net/libktorrent
devel/boost-headers net/powerdns
devel/boost-headers net/powerdns-ldap
devel/boost-headers net/powerdns-mysql
devel/boost-headers net/powerdns-pgsql
devel/boost-headers net/powerdns-recursor
devel/boost-headers net/powerdns-sqlite
devel/boost-headers print/scribus-qt4
devel/boost-headers security/kgpg
devel/boost-headers textproc/FlightCrew
devel/boost-headers textproc/source-highlight
devel/boost-headers www/kdewebdev4
devel/boost-headers x11/kde-workspace4
devel/boost-headers x11/py-kde4
devel/boost-jam devel/boost-headers
devel/boost-jam devel/boost-libs
devel/boost-jam devel/boost-python
meta-pkgs/boost
'

pkg_subgraph_deps -x1p "$boost_pkgs" src_summary19.txt |
sort |
cmp 'pkg_subgraph_deps #11.1.2' \
'audio/bmpx
audio/mp3diags
cad/librecad
cad/openscad
chat/konversation
converters/libvisio
databases/libcassandra
databases/mysql-workbench
devel/kdesdk4
devel/kdevelop4
devel/kdevplatform
devel/libthrift
devel/mdds
devel/monotone
devel/vera++
devel/xsd
editors/Sigil
editors/abiword-plugins
games/alephone
games/flightgear
games/holtz
games/pingus
games/pokerth
games/scummvm-tools
games/simgear
games/wesnoth
geography/merkaartor
graphics/aqsis
graphics/digikam
graphics/enblend-enfuse
graphics/exiv2-organize
graphics/gource
graphics/hugin
graphics/inkscape
graphics/kipi-plugins
graphics/panomatic
ham/gnuradio-audio-jack
ham/gnuradio-audio-oss
ham/gnuradio-audio-portaudio
ham/gnuradio-core
ham/gnuradio-core-docs
ham/gnuradio-examples
ham/gnuradio-gsm
ham/gnuradio-howto
ham/gnuradio-radio-astronomy
ham/gnuradio-trellis
ham/gnuradio-usrp
ham/gnuradio-video-sdl
ham/gnuradio-wxgui
ham/usrp
ham/usrp-docs
inputmethod/ibus-pinyin
mail/akonadi
math/cgal
math/fityk
math/xylib
misc/kdeadmin4
misc/kdepim-runtime4
misc/kdepim4
misc/kdepimlibs4
misc/kdeplasma-addons4
misc/libreoffice
misc/rocs
misc/tellico
multimedia/gnash
multimedia/mkvtoolnix
multimedia/mkvtoolnix-old
net/kdenetwork4
net/ktorrent
net/libktorrent
net/powerdns
net/powerdns-ldap
net/powerdns-mysql
net/powerdns-pgsql
net/powerdns-recursor
net/powerdns-sqlite
print/scribus-qt4
security/kgpg
textproc/FlightCrew
textproc/source-highlight
www/kdewebdev4
x11/kde-workspace4
x11/py-kde4
'

pkg_subgraph_deps -r1p "$boost_pkgs" src_summary19.txt |
sort |
cmp 'pkg_subgraph_deps #11.2' \
'devel/boost-headers devel/boost-libs
devel/boost-headers devel/boost-python
devel/boost-jam devel/boost-headers
devel/boost-jam devel/boost-libs
devel/boost-jam devel/boost-python
pkgtools/digest devel/boost-build
pkgtools/digest devel/boost-docs
pkgtools/digest devel/boost-headers
pkgtools/digest devel/boost-jam
pkgtools/digest devel/boost-libs
pkgtools/digest devel/boost-python
pkgtools/digest meta-pkgs/boost
'

pkg_subgraph_deps -v1p "$boost_pkgs" src_summary19.txt |
sort |
cmp 'pkg_subgraph_deps #11.3' \
'pkgtools/digest devel/boost-build
pkgtools/digest devel/boost-docs
pkgtools/digest devel/boost-headers
pkgtools/digest devel/boost-jam
pkgtools/digest devel/boost-libs
pkgtools/digest devel/boost-python
pkgtools/digest meta-pkgs/boost
'

pkg_subgraph_deps -vr1p "$boost_pkgs" src_summary19.txt |
sort |
cmp 'pkg_subgraph_deps #11.4' \
'devel/boost-headers audio/bmpx
devel/boost-headers audio/mp3diags
devel/boost-headers cad/librecad
devel/boost-headers cad/openscad
devel/boost-headers chat/konversation
devel/boost-headers converters/libvisio
devel/boost-headers databases/libcassandra
devel/boost-headers databases/mysql-workbench
devel/boost-headers devel/kdesdk4
devel/boost-headers devel/kdevelop4
devel/boost-headers devel/kdevplatform
devel/boost-headers devel/libthrift
devel/boost-headers devel/mdds
devel/boost-headers devel/monotone
devel/boost-headers devel/vera++
devel/boost-headers devel/xsd
devel/boost-headers editors/Sigil
devel/boost-headers editors/abiword-plugins
devel/boost-headers games/alephone
devel/boost-headers games/flightgear
devel/boost-headers games/holtz
devel/boost-headers games/pingus
devel/boost-headers games/pokerth
devel/boost-headers games/scummvm-tools
devel/boost-headers games/simgear
devel/boost-headers games/wesnoth
devel/boost-headers geography/merkaartor
devel/boost-headers graphics/aqsis
devel/boost-headers graphics/digikam
devel/boost-headers graphics/enblend-enfuse
devel/boost-headers graphics/exiv2-organize
devel/boost-headers graphics/gource
devel/boost-headers graphics/hugin
devel/boost-headers graphics/inkscape
devel/boost-headers graphics/kipi-plugins
devel/boost-headers graphics/panomatic
devel/boost-headers ham/gnuradio-audio-jack
devel/boost-headers ham/gnuradio-audio-oss
devel/boost-headers ham/gnuradio-audio-portaudio
devel/boost-headers ham/gnuradio-core
devel/boost-headers ham/gnuradio-core-docs
devel/boost-headers ham/gnuradio-examples
devel/boost-headers ham/gnuradio-gsm
devel/boost-headers ham/gnuradio-howto
devel/boost-headers ham/gnuradio-radio-astronomy
devel/boost-headers ham/gnuradio-trellis
devel/boost-headers ham/gnuradio-usrp
devel/boost-headers ham/gnuradio-video-sdl
devel/boost-headers ham/gnuradio-wxgui
devel/boost-headers ham/usrp
devel/boost-headers ham/usrp-docs
devel/boost-headers inputmethod/ibus-pinyin
devel/boost-headers mail/akonadi
devel/boost-headers math/cgal
devel/boost-headers math/fityk
devel/boost-headers math/xylib
devel/boost-headers misc/kdeadmin4
devel/boost-headers misc/kdepim-runtime4
devel/boost-headers misc/kdepim4
devel/boost-headers misc/kdepimlibs4
devel/boost-headers misc/kdeplasma-addons4
devel/boost-headers misc/libreoffice
devel/boost-headers misc/rocs
devel/boost-headers misc/tellico
devel/boost-headers multimedia/gnash
devel/boost-headers multimedia/mkvtoolnix
devel/boost-headers multimedia/mkvtoolnix-old
devel/boost-headers net/kdenetwork4
devel/boost-headers net/ktorrent
devel/boost-headers net/libktorrent
devel/boost-headers net/powerdns
devel/boost-headers net/powerdns-ldap
devel/boost-headers net/powerdns-mysql
devel/boost-headers net/powerdns-pgsql
devel/boost-headers net/powerdns-recursor
devel/boost-headers net/powerdns-sqlite
devel/boost-headers print/scribus-qt4
devel/boost-headers security/kgpg
devel/boost-headers textproc/FlightCrew
devel/boost-headers textproc/source-highlight
devel/boost-headers www/kdewebdev4
devel/boost-headers x11/kde-workspace4
devel/boost-headers x11/py-kde4
'
