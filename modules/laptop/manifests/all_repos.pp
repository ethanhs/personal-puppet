class laptop::all_repos {
  file { '/home/ethanhs/.all_repos':
    ensure => 'directory',
    owner  => 'ethanhs',
    group  => 'ethanhs',
    mode   => '0660',
  }

  file { '/home/ethanhs/.all_repos/all_repos.json':
    ensure  => file,
    content => lookup('laptop::all_repos::config_file_content'),
    owner   => 'ethanhs',
    group   => 'ethanhs',
    mode    => '0660',
  }

}
