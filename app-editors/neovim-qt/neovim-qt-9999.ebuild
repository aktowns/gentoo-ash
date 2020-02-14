# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Neovim client library and GUI, in Qt5."
HOMEPAGE="https://github.com/equalsraf/neovim-qt"
EGIT_REPO_URI="https://github.com/equalsraf/neovim-qt.git"

inherit cmake git-r3

LICENSE="ISC"
SLOT="0"
KEYWORDS=""

DEPEND="
	>=dev-qt/qtgui-5
	dev-libs/msgpack:0=
	app-editors/neovim
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_MSGPACK=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
