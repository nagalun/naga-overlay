# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/abique/hefur.git"

inherit git-r3 cmake

DESCRIPTION="Standalone C++ BitTorrent tracker"
HOMEPAGE="https://github.com/abique/hefur"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="control-iface"

# app-arch/xz-utils
DEPEND="
	net-libs/gnutls
	dev-libs/protobuf
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i "s/tracker-controller.hh//g" hefur/CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
        local mycmakeargs=(
                -DHEFUR_CONTROL_INTERFACE=$(usex control-iface ON OFF)
        )
        cmake_src_configure
}
