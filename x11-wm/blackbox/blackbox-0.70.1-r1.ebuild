# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.70.1.ebuild,v 1.14 2011/04/16 18:20:44 ulm Exp $

inherit autotools eutils

DESCRIPTION="A small, fast, full-featured window manager for X"
HOMEPAGE="http://blackboxwm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}wm/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="nls truetype debug"

RDEPEND="x11-libs/libXft
	x11-libs/libXt
	nls? ( sys-devel/gettext )
	truetype? ( media-libs/freetype )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-apps/sed-4
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc-4.3.patch" \
		"${FILESDIR}/${P}-asneeded.patch"
	if has_version ">=x11-libs/libX11-1.4.0"; then
		sed -i -e "s/_XUTIL_H_/_X11&/" lib/Util.hh || die #348556
	fi

	if use patch; then
		# Add [include-sub] function.
		# http://sourceforge.net/tracker/index.php?func=detail&aid=2499535&group_id=40696&atid=428682
		epatch "${FILESDIR}/${P}-include_subdir.patch"
	fi

	eautoreconf
}

src_compile() {
	econf \
		--sysconfdir=/etc/X11/${PN} \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable truetype xft)
	emake || die "emake failed"
}

src_install() {
	dodir /etc/X11/Sessions
	echo "/usr/bin/blackbox" > "${D}/etc/X11/Sessions/${PN}"
	fperms a+x /etc/X11/Sessions/${PN}

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* COMPLIANCE README* TODO || die
}
