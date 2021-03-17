# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
        "github.com/dave/jennifer v1.3.0"
        "github.com/dave/jennifer v1.3.0/go.mod"
        "github.com/davecgh/go-spew v1.1.0"
        "github.com/davecgh/go-spew v1.1.0/go.mod"
        "github.com/fatih/structtag v1.0.0"
        "github.com/fatih/structtag v1.0.0/go.mod"
        "github.com/gin-contrib/sse v0.0.0-20190301062529-5545eab6dad3"
        "github.com/gin-contrib/sse v0.0.0-20190301062529-5545eab6dad3/go.mod"
        "github.com/gin-gonic/gin v1.4.0"
        "github.com/gin-gonic/gin v1.4.0/go.mod"
        "github.com/golang/protobuf v1.3.1"
        "github.com/golang/protobuf v1.3.1/go.mod"
        "github.com/jessevdk/go-flags v1.4.0"
        "github.com/jessevdk/go-flags v1.4.0/go.mod"
        "github.com/jessevdk/go-flags v1.4.1-0.20181221193153-c0795c8afcf4"
        "github.com/jessevdk/go-flags v1.4.1-0.20181221193153-c0795c8afcf4/go.mod"
        "github.com/json-iterator/go v1.1.6"
        "github.com/json-iterator/go v1.1.6/go.mod"
        "github.com/mattn/go-isatty v0.0.7"
        "github.com/mattn/go-isatty v0.0.7/go.mod"
        "github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd"
        "github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
        "github.com/modern-go/reflect2 v1.0.1"
        "github.com/modern-go/reflect2 v1.0.1/go.mod"
        "github.com/phayes/permbits v0.0.0-20190612203442-39d7c581d2ee"
        "github.com/phayes/permbits v0.0.0-20190612203442-39d7c581d2ee/go.mod"
        "github.com/pmezard/go-difflib v1.0.0"
        "github.com/pmezard/go-difflib v1.0.0/go.mod"
        "github.com/reddec/struct-view v0.0.0-20191205120822-b0e32034c99a"
        "github.com/reddec/struct-view v0.0.0-20191205120822-b0e32034c99a/go.mod"
        "github.com/stretchr/objx v0.1.0/go.mod"
        "github.com/stretchr/testify v1.3.0"
        "github.com/stretchr/testify v1.3.0/go.mod"
        "github.com/ugorji/go v1.1.4"
        "github.com/ugorji/go v1.1.4/go.mod"
        "golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
        "golang.org/x/crypto v0.0.0-20190911031432-227b76d455e7"
        "golang.org/x/crypto v0.0.0-20190911031432-227b76d455e7/go.mod"
        "golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
        "golang.org/x/net v0.0.0-20190503192946-f4e77d36d62c"
        "golang.org/x/net v0.0.0-20190503192946-f4e77d36d62c/go.mod"
        "golang.org/x/net v0.0.0-20191204025024-5ee1b9f4859a"
        "golang.org/x/net v0.0.0-20191204025024-5ee1b9f4859a/go.mod"
        "golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
        "golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223"
        "golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
        "golang.org/x/sys v0.0.0-20190412213103-97732733099d"
        "golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
        "golang.org/x/text v0.3.0/go.mod"
        "gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
        "gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
        "gopkg.in/go-playground/assert.v1 v1.2.1"
        "gopkg.in/go-playground/assert.v1 v1.2.1/go.mod"
        "gopkg.in/go-playground/validator.v8 v8.18.2"
        "gopkg.in/go-playground/validator.v8 v8.18.2/go.mod"
        "gopkg.in/yaml.v2 v2.2.2"
        "gopkg.in/yaml.v2 v2.2.2/go.mod"
        )
go-module_set_globals

DESCRIPTION="Bootstrap your Tinc node quickly and easy"
HOMEPAGE="https://github.com/reddec/tinc-boot"
SRC_URI="https://github.com/reddec/tinc-boot/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86 arm64"
IUSE=""

DEPEND="<net-vpn/tinc-1.1"
RDEPEND="${DEPEND}"
BDEPEND="dev-go/go-md2man"

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	CGO_ENABLED=0 go build -ldflags="${LDFLAGS}" -o "${PN}" cmd/tinc-boot/main.go || die "build failed"
}

src_install() {
	dobin "${PN}"
	go-md2man -in MANUAL.md -out "${PN}.1" && doman "${PN}.1"
	einstalldocs
}
