class laptop::xfreerdp {
  file { '/usr/local/bin/rdp':
    ensure  => 'file',
    owner   => 'ethanhs',
    content => 'xfreerdp +compression +clipboard /f /u:ethanhs /v:100.110.103.10 /size:1920x1080',
    mode    => '0744',
  }
}
