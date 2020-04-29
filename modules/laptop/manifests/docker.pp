class laptop::docker {
  # TODO: replace with focal once updated
  if $::lsbdistcodename == 'focal' {
    $docker_dist_codename = 'eoan'
  } else {
    $docker_dist_codename = $::lsbdistcodename
  }

  apt::key { '9DC858229FC7DD38854AE2D88D81803C0EBFCD88':
    source => 'https://download.docker.com/linux/ubuntu/gpg',
  } ->
  apt::source { 'docker-ce':
    architecture => $::architecture,
    location     => 'https://download.docker.com/linux/ubuntu',
    repos        => 'stable',
    release      => $docker_dist_codename,
  } ->
  package { 'docker-ce':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }

  group { 'docker':
    ensure => present,
    name   => 'docker',
  } ->
  user { 'ethanhs':
    ensure     => present,
    home       => '/home/ethanhs',
    managehome => true,
    groups     => ['docker']
  }
}
