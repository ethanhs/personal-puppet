class desktop::gpg {

  file { 'gpg-agent.conf':
    path => "${::windows_env['APPDATA']}\\gnupg\\gpg-agent.conf",
    source => "puppet:///modules/desktop/gpg-agent.conf"
  }

  file { 'gpg.conf':
    path => "${::windows_env['APPDATA']}\\gnupg\\gpg.conf",
    source => "puppet:///modules/desktop/gpg.conf"
  }

  exec { 'restart gpg agent':
    command  => "gpgconf.exe --reload gpg-agent; gpgconf.exe --list-options gpg-agent",
    provider => powershell,
  }

}
