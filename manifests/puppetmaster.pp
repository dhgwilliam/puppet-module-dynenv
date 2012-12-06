class dynenv::puppetmaster {
  vcsrepo { '/usr/local/src/puppet-sync':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/dhgwilliam/puppet-sync.git',
    revision => 'fb60f220e2bb85e8d42a47e8c9f38dfdc4855194',
  }

  file { '/usr/local/bin/puppet-sync':
    ensure  => link,
    target  => '/usr/local/src/puppet-sync/puppet-sync',
    require => Vcsrepo['/usr/local/src/puppet-sync'],
  }

  file { $::dynenv::env_dir:
    ensure => directory,
    owner  => $::puppet_user,
    group  => $::dynenv::sync_user,
    mode   => '2770',
  }
}
