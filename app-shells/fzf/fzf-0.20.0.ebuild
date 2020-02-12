# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/junegunn/fzf"
EGO_VENDOR=(
"github.com/gdamore/encoding v1.0.0"
"github.com/gdamore/tcell v1.3.0"
"github.com/lucasb-eyer/go-colorful v1.0.3"
"github.com/mattn/go-isatty v0.0.12"
"github.com/mattn/go-runewidth v0.0.8"
"github.com/mattn/go-shellwords v1.0.9"
"github.com/saracen/walker 324a081bae7e"
"golang.org/x/crypto 69ecbb4d6d5d github.com/golang/crypto"
"golang.org/x/sync cd5d95a43a6e github.com/golang/sync"
"golang.org/x/sys d101bd2416d5 github.com/golang/sys"
"golang.org/x/text v0.3.2 github.com/golang/text")

inherit golang-build golang-vcs-snapshot

DESCRIPTION="A command-line fuzzy finder"
HOMEPAGE="https://github.com/junegunn/fzf"
SRC_URI="https://${EGO_PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0/${PVR}"
KEYWORDS="~amd64 ~x86"
IUSE="neovim vim"

DEPEND="vim? ( app-editors/vim ) neovim? ( app-editors/neovim )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	golang-build_src_compile
}

src_install() {
	dobin fzf
	einstalldocs

	doman "src/${EGO_PN}/man/man1/fzf.1"

	insinto /usr/share/fzf

	dodoc "src/${EGO_PN}/README.md" \
		"src/${EGO_PN}/README.md" \
		"src/${EGO_PN}/README-VIM.md"

	doins "src/${EGO_PN}/shell/completion.bash" "src/${EGO_PN}/shell/key-bindings.bash" \
		"src/${EGO_PN}/shell/completion.zsh" "src/${EGO_PN}/shell/key-bindings.zsh"

	if use neovim ; then
		insinto /usr/share/nvim/runtime/plugin
		doins "src/${EGO_PN}/plugin/fzf.vim"
	fi

	if use vim ; then
		insinto /usr/share/vim/vimfiles/plugin
		doins "src/${EGO_PN}/plugin/fzf.vim"
	fi
}

pkg_postinst() {
	if has_version app-shells/bash-completion ; then
		einfo "You may source files in /usr/share/fzf from your .bashrc"
		einfo "to get completion for fzf"
	fi
	if has_version app-shells/zsh-completions ; then
		einfo "You may source files in /usr/share/fzf from your .zshrc"
		einfo "to get completion for fzf"
	fi
}
