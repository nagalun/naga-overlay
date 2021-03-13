# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN="github.com/xtaci/kcptun"
EGO_SUM=(
        "github.com/BurntSushi/toml v0.3.1/go.mod"
        "github.com/coreos/go-iptables v0.4.2"
        "github.com/coreos/go-iptables v0.4.2/go.mod"
        "github.com/davecgh/go-spew v1.1.0/go.mod"
        "github.com/golang/snappy v0.0.1"
        "github.com/golang/snappy v0.0.1/go.mod"
        "github.com/google/gopacket v1.1.17"
        "github.com/google/gopacket v1.1.17/go.mod"
        "github.com/klauspost/cpuid v1.2.4/go.mod"
        "github.com/klauspost/cpuid v1.3.1"
        "github.com/klauspost/cpuid v1.3.1/go.mod"
        "github.com/klauspost/reedsolomon v1.9.9"
        "github.com/klauspost/reedsolomon v1.9.9/go.mod"
        "github.com/mmcloughlin/avo v0.0.0-20200803215136-443f81d77104"
        "github.com/mmcloughlin/avo v0.0.0-20200803215136-443f81d77104/go.mod"
        "github.com/pkg/errors v0.9.1"
        "github.com/pkg/errors v0.9.1/go.mod"
        "github.com/pmezard/go-difflib v1.0.0/go.mod"
        "github.com/stretchr/objx v0.1.0/go.mod"
        "github.com/stretchr/testify v1.6.1/go.mod"
        "github.com/templexxx/cpu v0.0.1"
        "github.com/templexxx/cpu v0.0.1/go.mod"
        "github.com/templexxx/cpu v0.0.7"
        "github.com/templexxx/cpu v0.0.7/go.mod"
        "github.com/templexxx/xorsimd v0.4.1"
        "github.com/templexxx/xorsimd v0.4.1/go.mod"
        "github.com/tjfoc/gmsm v1.3.2"
        "github.com/tjfoc/gmsm v1.3.2/go.mod"
        "github.com/urfave/cli v1.21.0"
        "github.com/urfave/cli v1.21.0/go.mod"
        "github.com/xtaci/kcp-go/v5 v5.5.16-0.20201009084714-dc0fc2364c92"
        "github.com/xtaci/kcp-go/v5 v5.5.16-0.20201009084714-dc0fc2364c92/go.mod"
        "github.com/xtaci/kcp-go/v5 v5.5.16-0.20201009115342-ce66a98f9547"
        "github.com/xtaci/kcp-go/v5 v5.5.16-0.20201009115342-ce66a98f9547/go.mod"
        "github.com/xtaci/kcp-go/v5 v5.5.17"
        "github.com/xtaci/kcp-go/v5 v5.5.17/go.mod"
        "github.com/xtaci/kcp-go/v5 v5.6.1"
        "github.com/xtaci/kcp-go/v5 v5.6.1/go.mod"
        "github.com/xtaci/lossyconn v0.0.0-20190602105132-8df528c0c9ae"
        "github.com/xtaci/lossyconn v0.0.0-20190602105132-8df528c0c9ae/go.mod"
        "github.com/xtaci/smux v1.5.14"
        "github.com/xtaci/smux v1.5.14/go.mod"
        "github.com/xtaci/smux v1.5.15"
        "github.com/xtaci/smux v1.5.15/go.mod"
        "github.com/xtaci/tcpraw v1.2.25"
        "github.com/xtaci/tcpraw v1.2.25/go.mod"
        "github.com/yuin/goldmark v1.1.27/go.mod"
        "github.com/yuin/goldmark v1.1.32/go.mod"
        "golang.org/x/arch v0.0.0-20190909030613-46d78d1859ac/go.mod"
        "golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
        "golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
        "golang.org/x/crypto v0.0.0-20191219195013-becbf705a915/go.mod"
        "golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
        "golang.org/x/crypto v0.0.0-20200728195943-123391ffb6de"
        "golang.org/x/crypto v0.0.0-20200728195943-123391ffb6de/go.mod"
        "golang.org/x/mod v0.2.0/go.mod"
        "golang.org/x/mod v0.3.0"
        "golang.org/x/mod v0.3.0/go.mod"
        "golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
        "golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
        "golang.org/x/net v0.0.0-20200226121028-0de0cce0169b/go.mod"
        "golang.org/x/net v0.0.0-20200625001655-4c5254603344/go.mod"
        "golang.org/x/net v0.0.0-20200707034311-ab3426394381"
        "golang.org/x/net v0.0.0-20200707034311-ab3426394381/go.mod"
        "golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
        "golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
        "golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208/go.mod"
        "golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
        "golang.org/x/sys v0.0.0-20190405154228-4b34438f7a67/go.mod"
        "golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
        "golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod"
        "golang.org/x/sys v0.0.0-20200808120158-1030fc2bf1d9"
        "golang.org/x/sys v0.0.0-20200808120158-1030fc2bf1d9/go.mod"
        "golang.org/x/text v0.3.0/go.mod"
        "golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
        "golang.org/x/tools v0.0.0-20200425043458-8463f397d07c/go.mod"
        "golang.org/x/tools v0.0.0-20200808161706-5bf02b21f123"
        "golang.org/x/tools v0.0.0-20200808161706-5bf02b21f123/go.mod"
        "golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
        "golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
        "golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
        "golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1"
        "golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
        "gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
        "gopkg.in/yaml.v2 v2.2.2/go.mod"
        "gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
        "rsc.io/pdf v0.1.1/go.mod"
        )
go-module_set_globals

DESCRIPTION="A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
HOMEPAGE="https://github.com/xtaci/kcptun"

SRC_URI="https://github.com/xtaci/kcptun/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

KEYWORDS="~amd64 ~mips"
LICENSE="MIT"
IUSE="+server"
SLOT="0"

RESTRICT="mirror"

src_compile() {
	for x in client $(usev server); do
		CGO_ENABLED=0 go build -v -work -x -ldflags "-X main.VERSION=${PV} -w" \
			-o "bin/${PN}-${x}" "${EGO_PN}/${x}" || die
	done
}

src_install() {
	dobin bin/${PN}-*
	dodoc README.md Dockerfile

	insinto "/etc/kcptun"
	for x in client $(usev server); do
		doins "${FILESDIR}"/example-${x}.json

		newinitd "${FILESDIR}"/kcptun-${x}.initd kcptun-${x}
		newconfd "${FILESDIR}"/kcptun-${x}.confd kcptun-${x}
	done
}

pkg_postinst() {
	ewarn "\nSuggested \"/etc/sysctl.conf\" parameters for better handling of UDP packets:"
	ewarn "    net.core.rmem_max=26214400 // BDP - bandwidth delay product"
	ewarn "    net.core.rmem_default=26214400"
	ewarn "    net.core.wmem_max=26214400"
	ewarn "    net.core.wmem_default=26214400"
	ewarn "    net.core.netdev_max_backlog=2048 // proportional to -rcvwnd"

	einfo "\nSee documentation:"
	einfo "    https://github.com/xtaci/kcptun#quickstart"
	einfo "    https://github.com/skywind3000/kcp/blob/master/README.en.md\n"
}
