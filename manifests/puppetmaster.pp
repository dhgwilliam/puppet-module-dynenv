class dynenv::puppetmaster {
  include dynenv::common
  $prefix = $::dynenv::local_prefix

  vcsrepo { "${prefix}/src/puppet-sync":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/pdxcat/puppet-sync.git',
    revision => '9f7952a8ed707e0210279c783f3c2fc884bf9b08',
  }

  file { "${prefix}/bin/puppet-sync":
    ensure  => link,
    target  => "${prefix}/src/puppet-sync/puppet-sync",
    require => Vcsrepo["${prefix}/src/puppet-sync"],
  }

  file { $::dynenv::env_dir:
    ensure => directory,
    owner  => $::dynenv::sync_user,
    group  => $::puppet_group,
    mode   => '2770',
  }
}
