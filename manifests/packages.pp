class localrepo::packages {
  package { ['createrepo','yum-utils']:
    ensure => present,
  }
}
