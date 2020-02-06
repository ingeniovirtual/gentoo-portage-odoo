# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="A user for LibreOffice."

ACCT_USER_GROUPS=( "${PN}" )
ACCT_USER_ID="-1"
ACCT_USER_HOME=/var/lib/"${PN}"
ACCT_USER_SHELL=/bin/bash

acct-user_add_deps
