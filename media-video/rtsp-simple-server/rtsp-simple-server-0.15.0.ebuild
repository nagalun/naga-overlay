# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module systemd

EGO_SUM=(
        "github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751"
        "github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751/go.mod"
        "github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d"
        "github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d/go.mod"
        "github.com/aler9/gortsplib v0.0.0-20210310150132-830e3079e366"
        "github.com/aler9/gortsplib v0.0.0-20210310150132-830e3079e366/go.mod"
        "github.com/aler9/rtmp v0.0.0-20210309202041-2d7177b7300d"
        "github.com/aler9/rtmp v0.0.0-20210309202041-2d7177b7300d/go.mod"
        "github.com/davecgh/go-spew v1.1.0"
        "github.com/davecgh/go-spew v1.1.0/go.mod"
        "github.com/davecgh/go-spew v1.1.1"
        "github.com/davecgh/go-spew v1.1.1/go.mod"
        "github.com/fsnotify/fsnotify v1.4.9"
        "github.com/fsnotify/fsnotify v1.4.9/go.mod"
        "github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51"
        "github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51/go.mod"
        "github.com/pion/randutil v0.1.0"
        "github.com/pion/randutil v0.1.0/go.mod"
        "github.com/pion/rtcp v1.2.4"
        "github.com/pion/rtcp v1.2.4/go.mod"
        "github.com/pion/rtp v1.6.1"
        "github.com/pion/rtp v1.6.1/go.mod"
        "github.com/pion/rtp v1.6.2"
        "github.com/pion/rtp v1.6.2/go.mod"
        "github.com/pion/sdp/v3 v3.0.2"
        "github.com/pion/sdp/v3 v3.0.2/go.mod"
        "github.com/pmezard/go-difflib v1.0.0"
        "github.com/pmezard/go-difflib v1.0.0/go.mod"
        "github.com/stretchr/objx v0.1.0/go.mod"
        "github.com/stretchr/testify v1.4.0"
        "github.com/stretchr/testify v1.4.0/go.mod"
        "github.com/stretchr/testify v1.6.1"
        "github.com/stretchr/testify v1.6.1/go.mod"
        "golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
        "golang.org/x/crypto v0.0.0-20201221181555-eec23a3978ad"
        "golang.org/x/crypto v0.0.0-20201221181555-eec23a3978ad/go.mod"
        "golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
        "golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
        "golang.org/x/sys v0.0.0-20191005200804-aed5e4c7ecf9"
        "golang.org/x/sys v0.0.0-20191005200804-aed5e4c7ecf9/go.mod"
        "golang.org/x/sys v0.0.0-20191026070338-33540a1f6037"
        "golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
        "golang.org/x/term v0.0.0-20201117132131-f5c789dd3221/go.mod"
        "golang.org/x/text v0.3.0/go.mod"
        "gopkg.in/alecthomas/kingpin.v2 v2.2.6"
        "gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod"
        "gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
        "gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
        "gopkg.in/yaml.v2 v2.2.2"
        "gopkg.in/yaml.v2 v2.2.2/go.mod"
        "gopkg.in/yaml.v2 v2.2.8"
        "gopkg.in/yaml.v2 v2.2.8/go.mod"
        "gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
        "gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
        )
go-module_set_globals

DESCRIPTION="RTSP server and RTSP proxy to read, publish and proxy media stream"
HOMEPAGE="https://github.com/aler9/rtsp-simple-server"
SRC_URI="https://github.com/aler9/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE=""
RESTRICT="test" # needs docker

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	go build -ldflags="${LDFLAGS}" || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin rtsp-simple-server
	insinto /etc/rtsp-simple-server
	doins rtsp-simple-server.yml

	newinitd "${FILESDIR}"/rtsp-simple-server.initd rtsp-simple-server
	newconfd "${FILESDIR}"/rtsp-simple-server.confd rtsp-simple-server
	systemd_dounit "${FILESDIR}"/rtsp-simple-server.service
}
