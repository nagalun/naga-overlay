# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

RNAME="2020-12"
SR="R"

DESCRIPTION="Eclipse IDE for C/C++"
HOMEPAGE="http://www.eclipse.org"

SRC_BASE="https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${RNAME}/${SR}/eclipse-cpp-${RNAME}-${SR}-linux-gtk"
#SRC_BASE="https://mirrors.xmission.com/eclipse/technology/epp/downloads/release/${RNAME}/${SR}/eclipse-cpp-${RNAME}-${SR}-linux-gtk"
SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz&r=1 -> ${P}-x86_64.tar.gz )
	arm64? ( ${SRC_BASE}-aarch64.tar.gz&r=1 -> ${P}-aarch64.tar.gz )
"

LICENSE="EPL-2.0"
SLOT="4.18"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""

# app-crypt/libsecret may be needed by plugins/org.eclipse.equinox.security.linux.*/libkeystorelinuxnative.so
# eclipse needs >=virtual/jdk-11 but it's masked. install it manually!
RDEPEND="
	>=virtual/jdk-1.8
	x11-libs/gtk+:2
"

S=${WORKDIR}/eclipse

src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	dodoc -r readme/.

	cp "${FILESDIR}"/eclipserc-bin "${T}/eclipserc-bin-${SLOT}" || die
	cp "${FILESDIR}"/eclipse-bin "${T}/eclipse-bin-${SLOT}" || die
	sed "s@%SLOT%@${SLOT}@" -i "${T}"/eclipse{,rc}-bin-${SLOT} || die

	insinto /etc
	newins "${T}"/eclipserc-bin-${SLOT} eclipserc-bin-${SLOT}

	newbin "${T}"/eclipse-bin-${SLOT} eclipse-cpp-${SLOT}
	make_desktop_entry "eclipse-cpp-${SLOT}" "Eclipse ${PV}" "${dest}/icon.xpm" "Development;IDE"
}

pkg_preinst() {
        xdg_pkg_preinst
}

pkg_postinst() {
        xdg_pkg_postinst
}

pkg_postrm() {
        xdg_pkg_postrm
}
