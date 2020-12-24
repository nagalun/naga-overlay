# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

DESCRIPTION="youtube-dl plugin for VLC"
HOMEPAGE="https://git.remlab.net/gitweb/?p=vlc-plugin-ytdl.git"
EGIT_REPO_URI="https://git.remlab.net/git/vlc-plugin-ytdl.git"

inherit git-r3 python-single-r1

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=media-video/vlc-3.0.0
	net-misc/youtube-dl
"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/001-create-pkgdatadir.patch"
)

pkg_setup() {
	python-single-r1_pkg_setup
}

mymakeargs=""
src_compile() {
	mymakeargs="
		PYTHON_CFLAGS="$(python_get_CFLAGS)"
		PYTHON_LIBS="$(python_get_LIBS)"
		PYTHON_SO="$(python_get_library_path)"
	"
	elog $mymakeargs
	emake $mymakeargs || die "emake failed"
}

