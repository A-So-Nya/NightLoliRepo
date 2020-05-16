EAPI=7

DESCRIPTION="Open-source xray engine"
HOMEPAGE="https://github.com/OpenXRay"
SRC_URI="https://github.com/OpenXRay/xray-16/archive/${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang debug"
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

		clang? (
				sys-devel/clang
		)
"

src_unpack() {
	if [[ -n ${A} ]]; then
		unpack ${A}
	fi
	mv ${WORKDIR}/xray-16-${PV} ${WORKDIR}/${PN}-${PV}
}

src_configure() {
	mkdir ${WORKDIR}/${PN}-${PV}/bin
	cd ${WORKDIR}/${PN}-${PV}/bin
	if use debug; then
		cmake ${WORKDIR}/${PN}-${PV} -DCMAKE_BUILD_TYPE=RelWithDebInfo
	elif use clang; then
		CC=clang CXX=clang++ cmake ${WORKDIR}/${PN}-${PV}
	elif use debug && use clang; then
		CC=clang CXX=clang++ cmake ${WORKDIR}/${PN}-${PV} -DCMAKE_BUILD_TYPE=RelWithDebInfo
	else
		cmake ${WORKDIR}/${PN}-${PV}
	fi
}

src_prepare() {
	default
}

src_compile(){
	default
}

src_install() {
	emake install
}
