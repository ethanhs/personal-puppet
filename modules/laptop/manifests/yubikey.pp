class laptop::yubikey {
  $yubico_pkgs = ['libpam-yubico', 'yubikey-manager', 'yubikey-luks']
  apt::ppa { 'ppa:yubico/stable': } ->
  package { $yubico_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
