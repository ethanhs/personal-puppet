class laptop::xfreerdp {
  file { '/usr/local/bin/rdp':
    ensure  => 'file',
    owner   => 'ethanhs',
    content => 'xfreerdp +compression +clipboard /f /u:ethanhs /v:192.168.0.146 /size:1920x1080',
    mode    => '0744',
  }
}
