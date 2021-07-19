class laptop::gpg {

  file { 'gpg-agent.conf':
    path   => '/home/ethanhs/.gnupg/gpg-agent.conf',
    source => 'puppet:///modules/laptop/gpg-agent.conf'
  }

  file { 'gpg.conf':
    mode   => '600',
    path   => '/home/ethanhs/.gnupg/gpg.conf',
    source => 'puppet:///modules/laptop/gpg.conf'
  }

  exec { 'restart gpg agent':
    command  => '/usr/bin/gpgconf --reload gpg-agent; /usr/bin/gpgconf --list-options gpg-agent',
  }

}
