# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user versionator

ODOO_PV="$(get_version_component_range 1-2)"

DESCRIPTION="Odoo Argentinian localization from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-argentina"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-argentina.git"
EGIT_COMMIT="4f31d874016a80b6d384dee95289013bfdf4d10d"
EGIT_MASTER="${ODOO_PV}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/account-financial-tools:${SLOT}
	dev-python/geopy
	dev-python/beautifulsoup:python-2
	dev-python/cryptography
	dev-python/pyopenssl
	dev-python/suds
	dev-python/pyafipws"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-geocoders.patch"
	epatch "${FILESDIR}/${PN}-invoice.patch"
	epatch "${FILESDIR}/${PN}-account_chart_monotrib.patch"
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${ODOO_PV}"
	dodir "${ADDONS_PATH}"

	PYAFIPWS_CACHE_PATH="/var/lib/odoo/.cache/pyafipws"
	PYAFIPWS_PATH="/usr/lib/python2.7/site-packages/pyafipws"
	dodir "${PYAFIPWS_CACHE_PATH}"
	dodir "${PYAFIPWS_PATH}"
	dosym "${PYAFIPWS_CACHE_PATH}" "${PYAFIPWS_PATH}"/cache || die

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md CONTRIBUTING.md ISSUE_TEMPLATE.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "${PYAFIPWS_CACHE_PATH}"
}
