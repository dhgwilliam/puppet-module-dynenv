define dynenv::user($username = $title, $ssh_key, $ssh_key_type) {
  ssh_authorized_key { "${username}-dynenv":
    ensure => present,
    key => $ssh_key,
    type => $ssh_key_type,
    require => User[$::dynenv::sync_user],
    user => $::dynenv::sync_user,
  }
}
