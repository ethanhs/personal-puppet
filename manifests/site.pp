node default {
  # Vcsrepo { require => Package['git'] }

  # Fix puppet's utterly broken virtual package code by disabling virtual packages
  # https://github.com/ocf/puppet/issues/735
  Package {
    allow_virtual => false,
  }

  include desktop
}
