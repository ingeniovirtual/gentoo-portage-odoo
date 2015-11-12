# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Alternative Reporting Engine."
HOMEPAGE="https://github.com/OCA/reporting-engine"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/reporting-engine.git"
EGIT_COMMIT="da305bc8cd8ad6afbf5d40b80c3bc2a9cc8dad72"
EGIT_MASTER="7.0"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="<app-office/odoo-8.0"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/addons"
	dodir ${ADDONS_PATH}
	rm -rf ${S}/__unported__

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo"
}
