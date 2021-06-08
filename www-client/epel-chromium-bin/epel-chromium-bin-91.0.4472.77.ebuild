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
        arm64? (
		${SRC_BASE}/aarch64/chromium-common-${PV}-${R}.aarch64.rpm -> ${P}-common-aarch64.rpm
		${SRC_BASE}/aarch64/chromium-${PV}-${R}.aarch64.rpm -> ${P}-aarch64.rpm
	)
"
#        amd64? (
#		${SRC_BASE}/x86_64/chromium-common-${PV}-${R}.x86_64.rpm -> ${P}-common-x86_64.rpm
#		${SRC_BASE}/x86_64/chromium-${PV}-${R}.x86_64.rpm -> ${P}-x86_64.rpm
#	)

LICENSE="BSD"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="-* ~arm64"
IUSE="wayland"

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
	=dev-libs/icu-67*:0
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
        wayland? (
                dev-libs/wayland:=
                dev-libs/libffi:=
                x11-libs/gtk+:3[wayland,X]
                x11-libs/libdrm:=
                x11-libs/libxkbcommon:=
        )
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

RDEPEND="${COMMON_DEPEND}
        x11-misc/xdg-utils
        virtual/opengl
        virtual/ttf-fonts
	!www-client/chromium
	!www-client/chromium-bin
"
BDEPEND="app-arch/gzip"

DEPEND="${COMMON_DEPEND}"

src_install() {
	local CHROMIUM_HOME="/usr/$(get_libdir)/chromium-browser"
	local CHROMIUM_ETC="/etc/chromium"

	pushd etc/chromium
	insinto "${CHROMIUM_ETC}"
	doins -r native-messaging-hosts policies
	newins "${FILESDIR}/chromium.default" "default"
	popd

	pushd usr/share
	dodoc -r doc/chromium/*

	#for size in 24 48 64 128 256 ; do
	#	newicon -s ${size} "icons/hicolor/${size}x${size}/apps/chromium-browser.png" \
	#		chromium-browser.png
	#done

	#for size in 16 32 ; do
	#	newicon -s ${size} "icons/hicolor/64x64/apps/chromium-browser.png" \
	#		chromium-browser.png
	#done

	newicon "icons/hicolor/256x256/apps/chromium-browser.png" chromium-browser.png

	domenu applications/chromium-browser.desktop

	insinto /usr/share/gnome-control-center/default-apps
	doins gnome-control-center/default-apps/chromium-browser.xml

	gzip -d man/man1/chromium-browser.1.gz
	doman man/man1/chromium-browser.1
	dosym chromium-browser.1 /usr/share/man/man1/chromium.1
	popd

	pushd usr/lib64/chromium-browser
        insinto "${CHROMIUM_HOME}"
	exeinto "${CHROMIUM_HOME}"
        doins -r *
	doexe chrome-sandbox chromium-browser chromium-browser.sh xdg-mime xdg-settings
	popd

	sed -e "s:@@OZONE_AUTO_SESSION@@:$(usex wayland true false):g" "${FILESDIR}/epel-chromium-launcher.sh" > epel-chromium-launcher.sh || die
	doexe epel-chromium-launcher.sh

	dosym "${CHROMIUM_HOME}/epel-chromium-launcher.sh" /usr/bin/chromium-browser
	dosym "${CHROMIUM_HOME}/epel-chromium-launcher.sh" /usr/bin/chromium
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
