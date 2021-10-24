
# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Linux Userspace x86_64 Emulator with a twist, targeted at ARM64 Linux devices"
HOMEPAGE="https://box86.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+binfmt +dynarec +custom-cflags rpi4arm64 rk3326 rk3399 tegrax1 phytium sd845 larch64"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/ptitSeb/box64.git"
	inherit git-r3
else
	SRC_URI="https://github.com/ptitSeb/box64/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm64"
fi

#	|| ( cross-armv7a-hardfloat-linux-gnueabihf/gcc cross-arm-hardfloat-linux-gnueabihf/gcc )
DEPEND="
	>=dev-lang/python-3
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	# don't override cflags
	if use custom-cflags; then
		sed -i "s/^\s*add_definitions(-pipe/#/g" CMakeLists.txt
	fi

	if ! use binfmt; then
		sed -i "s/^\s*install(.*binfmt/#/g" CMakeLists.txt
	fi

	cmake_src_prepare
}

src_configure() {
        local mycmakeargs=(
                -DARM_DYNAREC=$(usex dynarec ON OFF)
                -DRPI4ARM64=$(usex rpi4arm64 ON OFF)
                -DRK3326=$(usex rk3326 ON OFF)
                -DRK3399=$(usex rk3399 ON OFF)
                -DTEGRAX1=$(usex tegrax1 ON OFF)
                -DPHYTIUM=$(usex phytium ON OFF)
                -DSD845=$(usex sd845 ON OFF)
                -DLARCH64=$(usex larch64 ON OFF)
		-DNOGIT=$([[ ${PV} == *9999 ]] && echo OFF || echo ON)
        )
        cmake_src_configure
}
