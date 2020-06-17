EAPI=5
inherit git-r3

DESCRIPTION="Small set of tools to control UKSM"
HOMEPAGE="https://github.com/mantheman/uksmtools"
LICENSE="GPL-2"

EGIT_REPO_URI="https://github.com/mantheman/uksmtools.git"
EGIT_BRANCH="master"
SRC_URI=""

SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-devel/gcc
	sys-devel/make
"
src_install(){
	make \
	prefix=${ED}/usr/bin \
	datadir=${ED}/usr/share \
	infodir=${ED}/usr/share/info \
	localstatedir=${ED}/var/lib \
	mandir=${ED}/usr/share/man \
	sysconfdir=${ED}/etc \
	${EXTRA_EINSTALL} \
	make options \
	install
}