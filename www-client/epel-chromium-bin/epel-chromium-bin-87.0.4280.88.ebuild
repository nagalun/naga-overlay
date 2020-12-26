# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg rpm

R="1.el8"

DESCRIPTION="Open-source version of Google Chrome web browser - Binary from EPEL8 repo"
HOMEPAGE="
	http://chromium.org/
	https://koji.fedoraproject.org/koji/packageinfo?packageID=22672
"

SRC_BASE="https://kojipkgs.fedoraproject.org/packages/chromium/${PV}/${R}"
SRC_URI="
        amd64? (
		${SRC_BASE}/x86_64/chromium-common-${PV}-${R}.x86_64.rpm -> ${P}-common-x86_64.rpm
		${SRC_BASE}/x86_64/chromium-${PV}-${R}.x86_64.rpm -> ${P}-x86_64.rpm
	)
        arm64? (
		${SRC_BASE}/aarch64/chromium-common-${PV}-${R}.aarch64.rpm -> ${P}-common-aarch64.rpm
		${SRC_BASE}/aarch64/chromium-${PV}-${R}.aarch64.rpm -> ${P}-aarch64.rpm
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""

S="${WORKDIR}"

COMMON_X_DEPEND="
        media-libs/mesa:=[gbm]
        x11-libs/libX11:=
        x11-libs/libXcomposite:=
        x11-libs/libXcursor:=
        x11-libs/libXdamage:=
        x11-libs/libXext:=
        x11-libs/libXfixes:=
        >=x11-libs/libXi-1.6.0:=
        x11-libs/libXrandr:=
        x11-libs/libXrender:=
        x11-libs/libXtst:=
        x11-libs/libXScrnSaver:=
        x11-libs/libxcb:=
"

#       vaapi? ( >=x11-libs/libva-2.7:=[X,drm] )
COMMON_DEPEND="
        app-arch/bzip2:=
        >=net-print/cups-2:=
        dev-libs/expat:=
        dev-libs/glib:2
        >=dev-libs/libxml2-2.9.4-r3:=[icu]
        dev-libs/nspr:=
        >=dev-libs/nss-3.26:=
        >=media-libs/alsa-lib-1.0.19:=
        media-libs/fontconfig:=
        media-libs/freetype:=
        >=media-libs/harfbuzz-2.4.0:0=[icu(-)]
        media-libs/libjpeg-turbo:=
        media-libs/libpng:=
        sys-apps/dbus:=
        sys-apps/pciutils:=
        virtual/udev
        x11-libs/cairo:=
        x11-libs/gdk-pixbuf:2
        x11-libs/pango:=
        media-libs/flac:=
        >=media-libs/libwebp-0.4.0:=
        sys-libs/zlib:=[minizip]
        ${COMMON_X_DEPEND}
        >=app-accessibility/at-spi2-atk-2.26:2
        >=app-accessibility/at-spi2-core-2.26:2
        >=dev-libs/atk-2.26
        x11-libs/gtk+:3[X]
"

#        pulseaudio? ( media-sound/pulseaudio:= )
#        system-ffmpeg? (
#                >=media-video/ffmpeg-4.3:=
#                || (
#                        media-video/ffmpeg[-samba]
#                        >=net-fs/samba-4.5.10-r1[-debug(-)]
#                )
#                >=media-libs/opus-1.3.1:=
#        )
#        wayland? (
#                dev-libs/wayland:=
#                dev-libs/libffi:=
#                x11-libs/gtk+:3[wayland,X]
#                x11-libs/libdrm:=
#                x11-libs/libxkbcommon:=
#        )

RDEPEND="${COMMON_DEPEND}
        x11-misc/xdg-utils
        virtual/opengl
        virtual/ttf-fonts
"

DEPEND="${COMMON_DEPEND}"

src_install() {
	local CHROMIUM_HOME="/usr/$(get_libdir)/chromium-browser"
	local CHROMIUM_ETC="/etc/chromium"

	pushd etc/chromium
	insinto "${CHROMIUM_ETC}"
	doins -r *
	popd

	pushd usr/share
	domenu applications/chromium-browser.desktop
	dodoc -r doc/chromium/*

	for size in 24 48 64 128 256 ; do
		doicon -s ${size} "icons/hicolor/${size}x${size}/apps/chromium-browser.png"
	done

	doman man/man1/chromium-browser.1.gz
	popd

	pushd usr/lib64/chromium-browser
        insinto "${CHROMIUM_HOME}"
	exeinto "${CHROMIUM_HOME}"
        doins -r *
	doexe chrome-sandbox chromium-browser chromium-browser.sh xdg-mime xdg-settings
	popd

	dosym "${CHROMIUM_HOME}/chromium-browser.sh" /usr/bin/chromium-browser
	dosym "${CHROMIUM_HOME}/chromium-browser.sh" /usr/bin/chromium
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
