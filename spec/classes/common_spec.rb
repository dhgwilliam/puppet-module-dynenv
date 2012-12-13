require 'spec_helper'

describe 'dynenv::common', :type => :class do
  let(:pre_condition) {
    'class { \'dynenv\':
      sync_user         => \'puppet-sync\',
      puppetmaster_fqdn => \'puppetmaster.puppetlabs.test\',
      githost_fqdn      => \'githost.puppetlabs.test\',
      git_repo          => \'/var/lib/git/puppet\',
    }'
  }

  context 'puppetmaster' do
    let(:node) { 'puppetmaster.puppetlabs.test' }

    it { should contain_user('puppet-sync').with(
      'ensure' => 'present',
      'home'   => '/var/lib/puppet-sync'
    ) }

    it { should contain_file('/var/lib/puppet-sync').with(
      'ensure'  => 'directory',
      'owner'   => 'puppet-sync',
      'require' => 'User[puppet-sync]'
    ) }

    it { should contain_file('/var/lib/puppet-sync/.ssh').with(
      'ensure'  => 'directory',
      'owner'   => 'puppet-sync',
      'mode'    => '0700',
      'require' => 'File[/var/lib/puppet-sync]'
    ) }

    it { should contain_exec('ssh-keygen').with(
      'creates' => '/var/lib/puppet-sync/.ssh/id_rsa',
      'command' => '/usr/bin/ssh-keygen -t rsa -b 4096 -N "" -f /var/lib/puppet-sync/.ssh/id_rsa',
      'require' => 'File[/var/lib/puppet-sync/.ssh]'
    ) }

    it { should contain_file('/var/lib/puppet-sync/.ssh/id_rsa').with(
      'ensure'  => 'present',
      'owner'   => 'puppet-sync',
      'mode'    => '0600',
      'require' => 'Exec[ssh-keygen]'
    ) }

    it { should contain_file('/etc/ssh/ssh_known_hosts').with(
      'ensure' => 'file',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644'
    ) }
  end

  context 'githost' do
    let(:node) { 'githost.puppetlabs.test' }

    it { should contain_user('puppet-sync').with(
      'ensure' => 'present',
      'home'   => '/var/lib/puppet-sync'
    ) }

    it { should contain_file('/var/lib/puppet-sync').with(
      'ensure'  => 'directory',
      'owner'   => 'puppet-sync',
      'require' => 'User[puppet-sync]'
    ) }

    it { should contain_file('/var/lib/puppet-sync/.ssh').with(
      'ensure'  => 'directory',
      'owner'   => 'puppet-sync',
      'mode'    => '0700',
      'require' => 'File[/var/lib/puppet-sync]'
    ) }

    it { should contain_exec('ssh-keygen').with(
      'creates' => '/var/lib/puppet-sync/.ssh/id_rsa',
      'command' => '/usr/bin/ssh-keygen -t rsa -b 4096 -N "" -f /var/lib/puppet-sync/.ssh/id_rsa',
      'require' => 'File[/var/lib/puppet-sync/.ssh]'
    ) }

    it { should contain_file('/var/lib/puppet-sync/.ssh/id_rsa').with(
      'ensure'  => 'present',
      'owner'   => 'puppet-sync',
      'mode'    => '0600',
      'require' => 'Exec[ssh-keygen]'
    ) }

    it { should contain_file('/etc/ssh/ssh_known_hosts').with(
      'ensure' => 'file',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644'
    ) }
  end
end
