# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="Extracts emails and attachments saved in Microsoft Outlook's .msg files"
HOMEPAGE="https://github.com/mattgwwalker/msg-extractor"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S=${WORKDIR}/${P}
