# pkg_summary4view
pkg_grep_summary -s PKGPATH 'wip/pkg_summary-utils' \
    < src_summary.txt |
pkg_summary4view |
cmp 'pkg_summary4view #1' \
'------------------------------------------------------------
PKGNAME:        pkg_summary-utils-0.18.1
PKGPATH:        wip/pkg_summary-utils
DEPENDS:       
    awk-pkgsrc-dewey>=0.5.6:../../wip/awk-pkgsrc-dewey
    pipestatus-[0-9]*:../../devel/pipestatus
    runawk>=0.12.1:../../wip/runawk
BUILD_DEPENDS: 
    checkperms>=1.1:../../sysutils/checkperms
CONFLICTS:     
    paexec<0.9.0
    pkg_cmp_summary-[0-9]*
    pkg_src_summary-[0-9]*
    pkg_src_update_summary-[0-9]*
    pkg_summary4view-[0-9]*
    pkg_update_summary-[0-9]*
HOMEPAGE:       http://www.mova.org/~cheusov/pub/pkg_summary-utils/
COMMENT:        Utilities for manipulating pkg_summary(5) files
MAINTAINER:     cheusov@tut.by
CATEGORIES:     pkgtools

'

pkg_summary4view -h     2>&1 | grep pkg_summary4view | grep summary4view |
cmp 'pkg_summary4view #2' \
'pkg_summary4view - converts pkg_summary(5) to human readable format
usage: pkg_summary4view [OPTIONS] [files...]
'

pkg_summary4view < rpm_summary.txt |
cmp 'pkg_summary4view #3' \
'------------------------------------------------------------
Name:           libsqlite3
Version:        3.46.0
Release:        alt1
DistTag:        p11+353646.100.1.1
Architecture:   x86_64
Install_Date:   1731171223
Group:          System/Libraries
Size:           1470720
License:        ALT-Public-Domain
Source_RPM:     sqlite3-3.46.0-alt1.src.rpm
Build_Date:     Fri Jul 26 12:49:22 2024
Build_Host:     nbr-p11.hasher.altlinux.org
Packager:       Denis Medvedev <nbr@altlinux.org>
Vendor:         ALT Linux Team
Url:            http://www.sqlite.org/
Summary:        An Embeddable SQL Database Engine (shared library)
Description:   
    SQLite is a C library that implements an SQL database engine.
    Programs that link with the SQLite library can have SQL database
    access without running a separate RDBMS process.
Filenames:     
    /usr/lib64/libsqlite3.so.0
    /usr/lib64/libsqlite3.so.0.8.6

------------------------------------------------------------
Name:           paexec
Version:        1.1.5
Release:        alt2
DistTag:        p11+349938.200.2.1
Architecture:   x86_64
Install_Date:   1731171350
Group:          Networking/Other
Size:           205828
License:        MIT
Source_RPM:     paexec-1.1.5-alt2.src.rpm
Build_Date:     Tue Jun 25 22:28:40 2024
Build_Host:     cheusov-p11.hasher.altlinux.org
Packager:       Aleksey Cheusov <cheusov@altlinux.org>
Vendor:         ALT Linux Team
Url:            http://paexec.sourceforge.net/
Summary:        paexec distributes tasks over network or CPUs
Description:   
    Small program that processes a list of tasks in parallel
    on different CPUs, computers in a network or whatever else.
Filenames:     
    /usr/bin/paargs
    /usr/bin/paexec
    /usr/bin/paexec_reorder
    /usr/bin/pareorder
    /usr/share/doc/paexec-1.1.5
    /usr/share/doc/paexec-1.1.5/LICENSE
    /usr/share/doc/paexec-1.1.5/NEWS
    /usr/share/doc/paexec-1.1.5/README
    /usr/share/doc/paexec-1.1.5/TODO
    /usr/share/doc/paexec-1.1.5/paexec.pdf
    /usr/share/man/man1/paargs.1.xz
    /usr/share/man/man1/paexec.1.xz
    /usr/share/man/man1/paexec_reorder.1.xz
    /usr/share/man/man1/pareorder.1.xz

'
