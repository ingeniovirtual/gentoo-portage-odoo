# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} )

inherit eutils distutils-r1

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.odoo.com/"
SUBSLOT="$(ver_cut 1-2)"
MY_PV="$(ver_cut 3-4)"
SLOT="0/${SUBSLOT}"
SRC_URI="http://nightly.odoo.com/${SUBSLOT}/nightly/src/${PN}_${SUBSLOT}.${MY_PV}.tar.gz"
LICENSE="LGPL-3"
KEYWORDS="amd64 x86"
IUSE="ldap postgres ssl"

CDEPEND="
	acct-group/odoo
	acct-user/odoo
	ldap? ( dev-python/python-ldap )
	postgres? ( dev-db/postgresql:* )
	ssl? ( dev-python/pyopenssl )
	dev-nodejs/less
	dev-python/Babel
	~dev-python/chardet-3.0.4
	~dev-python/decorator-4.3.0
	~dev-python/docutils-0.14
	dev-python/ebaysdk
	dev-python/feedparser
	~dev-python/gevent-1.5.0
	~dev-python/greenlet-0.4.15
	dev-python/html2text
	dev-python/jinja
	~dev-python/libsass-0.17.0
	dev-python/lxml
	dev-python/mako
	dev-python/markupsafe
	dev-python/mock
	dev-python/num2words
	~dev-python/ofxparse-0.19
	dev-python/passlib
	dev-python/pillow[jpeg]
	~dev-python/polib-1.1.0
	dev-python/psutil
	dev-python/psycopg:2
	dev-python/pydot
	dev-python/pyparsing
	~dev-python/PyPDF2-1.26.0
	dev-python/pyserial
	dev-python/python-dateutil
	dev-python/pytz
	dev-python/pyusb
	~dev-python/qrcode-6.1
	dev-python/reportlab
	dev-python/requests
	dev-python/zeep
	~dev-python/vatnumber-1.2
	~dev-python/vobject-0.9.6.1
	dev-python/werkzeug
	dev-python/xlsxwriter
	dev-python/xlwt
	dev-python/xlrd
	media-gfx/wkhtmltox-bin"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"
PATCHES=(
	"${FILESDIR}/${PN}-${SUBSLOT}-report_invoice.xml.patch"
	"${FILESDIR}/${PN}-${SUBSLOT}-report_paperformat_data.xml.patch"
)

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${SUBSLOT}.post${MY_PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

python_install_all() {
	distutils-r1_python_install_all

	dodir "/var/lib/${PN}"

	newinitd "${FILESDIR}/${PN}-${SUBSLOT}" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	keepdir "/var/log/${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" "${PN}" || die
	dodir "/etc/${PN}"
	insinto "/etc/${PN}"
	newins "${FILESDIR}/${PN}-${SUBSLOT}.cfg" "${PN}.cfg" || die

	dodoc PKG-INFO README.md
}

pkg_postinst() {
	chown "${ODOO_USER}:${ODOO_GROUP}" "/var/log/${PN}"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/${PN}"

	elog "In order to setup the initial database, run:"
	elog " emerge --config =${CATEGORY}/${PF}"
	elog "Be sure the database is started before"
}

psqlquery() {
	psql -q -At -U postgres -d template1 -c "$@"
}

pkg_config() {
	einfo "In the following, the 'postgres' user will be used."
	if ! psqlquery "SELECT usename FROM pg_user WHERE usename = '${ODOO_USER}'" | grep -q "${ODOO_USER}"; then
		ebegin "Creating database user ${ODOO_USER}"
		createuser --username=postgres --createdb --no-adduser "${ODOO_USER}"
		eend $? || die "Failed to create database user"
	fi
}
