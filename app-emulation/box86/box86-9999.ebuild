
# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Linux Userspace x86 Emulator with a twist, targeted at ARM Linux devices"
HOMEPAGE="https://box86.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+binfmt +dynarec pandora pyra rpi2 rpi3 rpi4 goa-clone rk3399 phytium gameshell odroid power9 sd845"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/ptitSeb/box86.git"
	inherit git-r3
else
	SRC_URI="https://github.com/ptitSeb/box86/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm ~arm64"
fi

# needs a crossdev target, create with crossdev -S -t armv7a-hardfloat-linux-gnueabihf
DEPEND="
	arm64? ( || (
		cross-armv7a-hardfloat-linux-gnueabihf/gcc
		cross-arm-hardfloat-linux-gnueabihf/gcc ) )
	>=dev-lang/python-3
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	if use arm64; then
		local CCOMPILER="armv7a-hardfloat-linux-gnueabihf"
		if has_version cross-arm-hardfloat-linux-gnueabihf/gcc; then
			CCOMPILER="arm-hardfloat-linux-gnueabihf"
		fi

		# force toolchain change, "if" guarding set(CMAKE_C_COMPILER
		#sed -i "s/if(RK3399/if(1/" CMakeLists.txt
		sed -i "s/arm-linux-gnueabihf/${CCOMPILER}/g" CMakeLists.txt
		# this is probably not the right way to do it
		export CC=${CCOMPILER}-gcc

		filter-flags -march=native -mcpu=native -mtune=native

		append-ldflags "-Wl,--dynamic-linker=$(echo /usr/${CCOMPILER}/lib/ld-linux-armhf.so.?)"
		append-ldflags "-Wl,--rpath=$(ls -1d /usr/lib/gcc/${CCOMPILER}/* | head -n1):/usr/${CCOMPILER}/lib:/usr/${CCOMPILER}/usr/lib"
	fi

	if ! use binfmt; then
		sed -i "s/^\s*install(.*binfmt/#/g" CMakeLists.txt
	fi

	cmake_src_prepare
}

src_configure() {
        local mycmakeargs=(
                -DARM_DYNAREC=$(usex dynarec ON OFF)
                -DPANDORA=$(usex pandora ON OFF)
                -DPYRA=$(usex pyra ON OFF)
                -DRPI2=$(usex rpi2 ON OFF)
                -DRPI3=$(usex rpi3 ON OFF)
                -DRPI4=$(usex rpi4 ON OFF)
                -DGOA_CLONE=$(usex goa-clone ON OFF)
                -DRK3399=$(usex rk3399 ON OFF)
                -DPHYTIUM=$(usex phytium ON OFF)
                -DGAMESHELL=$(usex gameshell ON OFF)
                -DODROID=$(usex odroid ON OFF)
                -DPOWER9=$(usex power9 ON OFF)
                -DSD845=$(usex sd845 ON OFF)
		-DNOGIT=$([[ ${PV} == *9999 ]] && echo OFF || echo ON)
        )
        cmake_src_configure
}
