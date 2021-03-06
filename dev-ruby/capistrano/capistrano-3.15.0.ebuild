# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby24 ruby25 ruby26"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="A distributed application deployment system"
HOMEPAGE="https://capistranorb.com/"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/airbrussh-1.0.0
	>=dev-ruby/sshkit-1.9:0
	>=dev-ruby/rake-10.0.0
	dev-ruby/i18n:*
	!!<dev-ruby/capistrano-2.15.5-r2"
ruby_add_bdepend "
	test? (	dev-ruby/mocha )"

pkg_postinst() {
	einfo "Capistrano 3.x has some breaking changes. Please check the CHANGELOG: http://goo.gl/SxB0lr"
	einfo "If you're upgrading Capistrano from 2.x, we recommend to read the upgrade guide: http://goo.gl/4536kB"
	einfo "The 'deploy:restart' hook for passenger applications is now in a separate gem called capistrano-passenger.  Just add it to your Gemfile and require it in your Capfile."
}
