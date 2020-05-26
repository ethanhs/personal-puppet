class laptop::ssh {
  file { '.ssh/config':
    path   => '/home/ethanhs/.ssh/config',
    source => 'puppet:///modules/laptops/ssh_config',
  }
}
