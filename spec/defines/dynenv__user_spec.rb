require 'spec_helper'

describe 'dynenv::user', :type => :define do
  let(:node) { 'puppetmaster.puppetlabs.test' }
  let(:pre_condition) {
    'class { \'dynenv\':
      sync_user         => \'puppet-sync\',
      puppetmaster_fqdn => \'puppetmaster.puppetlabs.test\',
      githost_fqdn      => \'githost.puppetlabs.test\',
      git_repo          => \'/var/lib/git/puppet\',
    }'
  }
  let(:title) { 'david-dynenv' }
  let(:params) { {
    :username     => 'david',
    :ssh_key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCU/2sgvrAARXcyjELwBfiVwiWLIvgx9rKsEyv3qJS8m0bDWCFACIA/Q+fQI8NHaqTVlvonznxvw704vgv4G+i2q/xjt416fjBoEyZJTBYjFblDYfEH48/pUSdCVwvCE37o/YTI1C7njraOomBSz6Wrr0HI2n3SjHwjcM1sZ5gWezT8mO/9zkuwLISTnMkqzC6Iir6lvjLGPqB1BvyHus+xwggLOmdSd3Shd4cIaUq9txoieHF1hCKIBjNw7E5xWkUyHhQkHlTJ+vs3cPJnHzFAtQictfSzcHuzR6asxRQBA0lYylp4Qx6Z5pRgZ0U0MTRjMkNFzUA9j7JOKmGMj+NN',
    :ssh_key_type => 'rsa'
  } }
    
  it { should contain_ssh_authorized_key('david-dynenv').with(
    'ensure' => 'present',
    'key'    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCU/2sgvrAARXcyjELwBfiVwiWLIvgx9rKsEyv3qJS8m0bDWCFACIA/Q+fQI8NHaqTVlvonznxvw704vgv4G+i2q/xjt416fjBoEyZJTBYjFblDYfEH48/pUSdCVwvCE37o/YTI1C7njraOomBSz6Wrr0HI2n3SjHwjcM1sZ5gWezT8mO/9zkuwLISTnMkqzC6Iir6lvjLGPqB1BvyHus+xwggLOmdSd3Shd4cIaUq9txoieHF1hCKIBjNw7E5xWkUyHhQkHlTJ+vs3cPJnHzFAtQictfSzcHuzR6asxRQBA0lYylp4Qx6Z5pRgZ0U0MTRjMkNFzUA9j7JOKmGMj+NN',
    'type'   => 'rsa',
    'user'   => 'puppet-sync'
  ) }
end

