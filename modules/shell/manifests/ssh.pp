class shell::ssh {
  file { '.ssh/config':
    path   => "${facts['windows_env']['USERPROFILE']}/.ssh/config",
    source => 'puppet:///modules/shell/ssh_config',
  }
}
