# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Purchases, Workflow and Organization."
HOMEPAGE="https://github.com/OCA/purchase-workflow"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/purchase-workflow.git"
EGIT_COMMIT="89ef013dc256a7f9b11715c311462e32c36ad86f"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/sale-workflow:${SLOT}
	app-odoo/server-tools:${SLOT}
	app-odoo/stock-logistics-workflow:${SLOT}"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
