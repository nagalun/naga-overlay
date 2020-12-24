# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Firmware for BCM20702"
HOMEPAGE=""
SRC_URI="https://github.com/winterheart/broadcom-bt-firmware/raw/master/brcm/BCM20702A1-0a5c-21e6.hcd"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

# Only one file no sub directory
S="${WORKDIR}"

src_unpack()
{
	cp "${DISTDIR}/${A}" "${WORKDIR}" || die
}

src_install()
{
	insinto /lib/firmware/brcm
	doins BCM20702A1-0a5c-21e6.hcd
}

