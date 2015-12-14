# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Restricts the same user to login simultaneously in Odoo."
HOMEPAGE="https://github.com/NevproBusinessSolutions/restrict-multiple-signin-for-same-user"
SRC_URI=""
EGIT_REPO_URI="https://github.com/NevproBusinessSolutions/restrict-multiple-signin-for-same-user.git"
EGIT_COMMIT="b13e770417af95fad8f369915c67e3ef6fe0be67"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir ${ADDONS_PATH}

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
