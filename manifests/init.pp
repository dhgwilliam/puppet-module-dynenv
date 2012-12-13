# == Class: dynenv
#
# Full description of class dynenv here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { dynenv:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# David Gwilliam <david@puppetlabs.com>
#
# === Copyright
#
# Copyright 2012 David Gwilliam, unless otherwise noted.
#
class dynenv(
  $sync_user,
  $puppetmaster_fqdn,
  $githost_fqdn,
  $git_repo,
  $repo_owner = $sync_user,
  $repo_group = $sync_user,
  $env_dir = '/etc/puppet/environments'
) {
  case $::fqdn {
    $puppetmaster_fqdn: { include dynenv::puppetmaster }
    $githost_fqdn: { include dynenv::githost }
  }
}
