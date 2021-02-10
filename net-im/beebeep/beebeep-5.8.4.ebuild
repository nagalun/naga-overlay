# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BEEBEEP_REV="r1476"

DESCRIPTION="Secure LAN Messenger"
HOMEPAGE="https://www.beebeep.net/"
SRC_URI="http://netcologne.dl.sourceforge.net/project/beebeep/Sources/beebeep-code-${PV}.zip"

S="${WORKDIR}/${PN}-code-${BEEBEEP_REV}"

inherit desktop qmake-utils xdg

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="amd64 ~x86 arm64"
REQUIRED_USE=""
# Beebeep seems to crash under wayland, X-only forces running through X
IUSE="hd-emojis telemetry +X-only"

DEPEND="
	>=dev-qt/qtcore-5
	>=dev-qt/qtmultimedia-5
	x11-libs/libxcb
"

RDEPEND="${DEPEND}"

PATCHES=( )

src_configure() {
	eqmake5 "${S}/beebeep-desktop.pro"
}

src_prepare() {
	if ! use telemetry; then
		PATCHES+=("${FILESDIR}/001-no-analytics.patch")
	fi

	if ! use hd-emojis; then
		PATCHES+=("${FILESDIR}/002-no-hd-emojis.patch")
	fi

	default
}

src_install() {
	insinto "/usr/lib/${PN}"
	doins test/lib*.so*
	dobin "test/${PN}"

	insinto "/usr/share/${PN}"
	doins misc/beep.wav
	doins locale/beebeep_*.qm

	doicon src/images/beebeep.png

	local EXTRA_APP_ENV="env"

	if use X-only; then
		EXTRA_APP_ENV+=" QT_QPA_PLATFORM=xcb"
	fi

	make_desktop_entry "${EXTRA_APP_ENV} ${PN}" "BeeBEEP" beebeep Network
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
