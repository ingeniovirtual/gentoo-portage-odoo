# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="A tiny script to issue and renew TLS certs from Let's Encrypt"
HOMEPAGE="https://github.com/diafygi/acme-tiny"
SRC_URI="mirror://pypi/a/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-python/setuptools_scm"

RDEPEND="dev-python/fuse-python"
