class laptop::yubikey {
  $yubico_pkgs = ['libpam-yubico', 'yubikey-manager', 'yubikey-luks']
  apt::ppa { 'ppa:yubico/stable': } ->
  package { $yubico_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
  $pam_file = '/etc/pam.d/common-auth'
  file { $pam_file:
    ensure => present
  }->
  file_line { 'challenge-response yubikey':
    line => 'auth    required   pam_yubico.so mode=challenge-response',
    path => $pam_file,
  }
}
