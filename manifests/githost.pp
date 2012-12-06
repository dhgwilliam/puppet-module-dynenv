class dynenv::githost inherits dynenv {
  # you'll probably want to set
  # git config core.sharedRepository true

  file { $::dynenv::git_repo:
    ensure => directory,
    owner => $repo_owner,
    group => $repo_group, 
    mode => '2770',
  }

  file { "${::dynenv::git_repo}/.git/hooks/post-receive":
    ensure  => file,
    content => template('dynenv/post-receive.erb'),
    owner   => $repo_owner,
    mode    => '0770',
  }
}
