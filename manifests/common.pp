class dynenv::common {
  $home_dir = "/var/lib/${::dynenv::sync_user}"
  $private_key = "${home_dir}/.ssh/id_rsa"
  
  user { $::dynenv::sync_user:
    ensure  => present,
    home    => $home_dir,
  }

  file { $home_dir:
    ensure  => directory,
    owner   => $::dynenv::sync_user,
    require => User[$::dynenv::sync_user],
  }

  file { "${home_dir}/.ssh":
    ensure  => directory,
    owner   => $::dynenv::sync_user,
    mode    => '0700',
    require => File[$home_dir],
  }

  exec { 'ssh-keygen':
    creates => $private_key,
    command => "/usr/bin/ssh-keygen -t rsa -b 4096 -N \"\" -f ${private_key}",
    require => File["${home_dir}/.ssh"],
  }

  file { $private_key:
    ensure  => present,
    owner   => $::dynenv::sync_user,
    mode    => '0600',
    require => Exec['ssh-keygen'],
  }

  @@ssh_authorized_key { "${::fqdn}-puppet-sync_pubkey":
    type => 'ssh-rsa',
    key  => $::puppet_sync_pubkey,
    user => 'puppet-sync'
  }
  Ssh_authorized_key <<| |>>

  @@sshkey { $::fqdn: type => 'rsa', key => $::sshrsakey, } 
  Sshkey <<| |>>

  file {'/etc/ssh/ssh_known_hosts':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

}
