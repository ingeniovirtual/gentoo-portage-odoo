# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Library to extract data from Microsoft Excel spreadsheets"
HOMEPAGE="http://www.python-excel.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

python_prepare_all() {
	# Remove this if examples get reintroduced
	sed -i -e "s/test_names_demo/_&/" tests/test_open_workbook.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover || die "Test failed with ${EPYTHON}"
}
