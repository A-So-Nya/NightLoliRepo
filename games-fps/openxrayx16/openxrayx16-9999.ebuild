EAPI=7
inherit git-r3 cmake cmake-utils

EGIT_REPO_URI="https://github.com/OpenXRay/xray-16.git"
EGIT_BRANCH="xd_dev"
DESCRIPTION="Open-source xray engine"
HOMEPAGE="https://github.com/OpenXRay"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang debug"
RESTRICT=""

DEPEND="
		media-libs/glew
		media-libs/freeimage
		net-libs/liblockfile
		media-libs/openal
		dev-cpp/tbb
		dev-libs/crypto++
		media-libs/libtheora
		media-libs/libogg
		media-libs/libvorbis
		media-libs/libsdl2
		dev-libs/lzo
		media-libs/libjpeg-turbo
		sys-libs/readline
		dev-libs/libpcre2
		dev-libs/libpcre
		app-arch/lzop
		dev-vcs/git
		media-libs/libglvnd

		clang? (
				sys-devel/clang
		)
"
RDEPEND=${DEPEND}

S=${WORKDIR}/${PN}-${PV}
BUILD_DIR=${WORKDIR}/${PN}-${PV}/bin

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	if use clang; then
		CMAKE_BINARY="CC=clang CXX=clang++ cmake"
	else
		CMAKE_BINARY="cmake"
	fi

	if use debug; then 
		CMAKE_BUILD_TYPE=RelWithDebInfo
	else
		CMAKE_BUILD_TYPE=Release
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
}