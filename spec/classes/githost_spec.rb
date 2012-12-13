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

    context '$::fqdn matches githost_fqdn' do
      let (:node) { 'githost.puppetlabs.test' }

      it { should contain_class('dynenv::githost') }

      it { should contain_file('/var/lib/git/environments').with(
        'ensure' => 'directory',
        'owner'  => 'puppet-sync',
        'group'  => 'puppet-sync',
        'mode'   => '2770'
      ) }
    end

  end
end

