# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/direnv/direnv"
EGO_VENDOR=(
"github.com/BurntSushi/toml v0.3.1"
"github.com/direnv/go-dotenv 4cce6d1a66f7"
"golang.org/x/mod v0.2.0 github.com/golang/mod")

inherit golang-build golang-vcs-snapshot

DESCRIPTION="unclutter your .profile"
HOMEPAGE="http://direnv.net"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0/${PVR}"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	golang-build_src_compile
}

src_install() {
	dobin direnv
	einstalldocs

	doman "src/${EGO_PN}/man/direnv.1" \
		"src/${EGO_PN}/man/direnv-stdlib.1" \
		"src/${EGO_PN}/man/direnv.toml.1"

	insinto /usr/share/direnv

	dodoc "src/${EGO_PN}/README.md" \
		"src/${EGO_PN}/CHANGELOG.md"
}
