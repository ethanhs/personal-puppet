class laptop::tailscale {
  apt::key { 'tailscale':
    id     => '2596A99EAAB33821893C0A79458CA832957F5868',
    source => 'https://pkgs.tailscale.com/stable/ubuntu/focal.gpg';
  }

  apt::source { 'tailscale':
    architecture => 'amd64',
    location     => 'https://pkgs.tailscale.com/stable/ubuntu',
    release      => 'focal',
    repos        => 'main',
    require      => Apt::Key['tailscale'],
  }

  package {'tailscale': ensure => 'latest' }
}
