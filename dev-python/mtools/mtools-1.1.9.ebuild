# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

RESTRICT="test" # broken

DESCRIPTION="Flask support for MongoDB and with WTF model forms"
HOMEPAGE="https://pypi.python.org/pypi/mtools/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mlaunch mplotqueries test"

RDEPEND="mlaunch? ( dev-python/psutil[${PYTHON_USEDEP}]
					dev-python/pymongo[${PYTHON_USEDEP}] )
		mplotqueries? ( dev-python/matplotlib[${PYTHON_USEDEP}]
					dev-python/numpy[${PYTHON_USEDEP}] )"
DEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
}
