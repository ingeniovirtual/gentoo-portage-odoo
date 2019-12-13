# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( pypy{,3} python{2_7,3_{5,6,7,8}} )

inherit distutils-r1

DESCRIPTION="Simplifies the usage of decorators for the average programmer"
HOMEPAGE="https://github.com/micheles/decorator https://pypi.org/project/decorator/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( CHANGES.md )

distutils_enable_tests setup.py