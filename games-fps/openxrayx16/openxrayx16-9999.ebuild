EAPI=7
inherit git-r3 cmake-utils
DESCRIPTION="Open-source xray engine"
HOMEPAGE="https://github.com/OpenXRay"
SRC_URI=""
EGIT_HAS_SUBMODULES="true"
EGIT_PROJECT="xray-16"
EGIT_REPO_URI="https://github.com/OpenXRay/xray-16.git"
EGIT_OPTIONS="--recurse-submodules=yes"



LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang debug libglvnd"
RESTRICT=""

RDEPEND="
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

		clang? (
				sys-devel/clang
		)

		libglvnd? (
			media-libs/libglvnd
		)
"

src_unpack() {
	default
	mv ${WORKDIR}/xray-16-xd_dev ${WORKDIR}/${PN}-${PV}
}

src_configure() {
	mkdir ${WORKDIR}/${PN}-${PV}/bin
	cd ${WORKDIR}/${PN}-${PV}/bin
	if use debug; then
		cmake ${WORKDIR}/${PN}-${PV} -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_BINDIR=/usr/bin
	elif use clang; then
		CC=clang CXX=clang++ cmake ${WORKDIR}/${PN}-${PV} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_BINDIR=/usr/bin
	elif use debug && use clang; then
		CC=clang CXX=clang++ cmake ${WORKDIR}/${PN}-${PV} -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_BINDIR=/usr/bin
	else
		cmake ${WORKDIR}/${PN}-${PV} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_BINDIR=/usr/bin
	fi
}

src_compile(){
	cd ${WORKDIR}/${PN}-${PV}/bin
	emake
}

src_install() {
	cd ${WORKDIR}/${PN}-${PV}/bin
	emake install
}
