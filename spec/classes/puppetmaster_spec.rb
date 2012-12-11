require 'spec_helper'

describe 'dynenv', :type => :class do
  describe 'dynenv::init' do
    let (:title) 
    let (:params) { { 
      :sync_user         => 'puppet-sync', 
      :puppetmaster_fqdn => 'puppetmaster.puppetlabs.test',
      :githost_fqdn      => 'githost.puppetlabs.test',
      :git_repo          => '/var/lib/git/environments',
    } }

    context '$::fqdn matches puppetmaster_fqdn' do
      let (:node) { 'puppetmaster.puppetlabs.test' }

      it { should include_class('dynenv::puppetmaster') }

      it :type => :vcsrepo do
        should contain_vcsrepo('/usr/local/src/puppet-sync').with(
            'ensure'   => 'present',
            'provider' => 'git',
            'source'   => 'https://github.com/pdxcat/puppet-sync.git',
            'revision' => '9f7952a8ed707e0210279c783f3c2fc884bf9b08'
        )
      end
    end
  end
end
