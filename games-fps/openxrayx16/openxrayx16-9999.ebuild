EAPI=7

DESCRIPTION="Open-source xray engine"
HOMEPAGE="https://github.com/OpenXRay"
EGIT_REPO_URI="https://github.com/OpenXRay/xray-16"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang debug"
RESTRICT=""

RDEPEND="
		media-libs/glew
		media-libs/freeimage
		net-libs/loblockfile
		media-libs/openal
		dev-cpp/tbb
		dev-libs/crypto++
		media-libs/libtheora
		media-libs/libogg
		media-libs/libsdl2
		dev-libs/lzo
		media-libs/libjpeg-turbo
		sys-libs/deadling

		clang?
				sys-devel/clang
"

src_configure() {
	mkdir $(WORKDIR}/bin && cd ${WORKDIR}/bin
	if use debug; then
		cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo
	elif use clang; then
		CC=clang CXX=clang++ cmake ..
	elif use debug && use clang; then
		CC=clang CXX=clang++ cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo
	else
		cmake ..
	fi
}

src_prepare() {
	default
}

src_compile(){
	emake
}

src_install() {
	emake install
}
