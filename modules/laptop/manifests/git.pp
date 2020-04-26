class laptop::git {
  file { '.gitconfig':
    path   => '/home/ethanhs/.gitconfig',
    source => 'puppet:///modules/laptop/.gitconfig',
  }
}
