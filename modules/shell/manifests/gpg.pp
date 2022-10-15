class shell::gpg {

  file { 'gpg-agent.conf':
    path   => "${::windows_env['APPDATA']}\\gnupg\\gpg-agent.conf",
    source => 'puppet:///modules/shell/gpg-agent.conf'
  }

  file { 'gpg.conf':
    path   => "${::windows_env['APPDATA']}\\gnupg\\gpg.conf",
    source => 'puppet:///modules/shell/gpg.conf'
  }

  exec { 'restart gpg agent':
    command  => 'gpgconf.exe --reload gpg-agent; gpgconf.exe --list-options gpg-agent',
    provider => powershell,
  }

}
