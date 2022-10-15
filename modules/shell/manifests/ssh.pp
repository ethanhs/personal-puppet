class shell::ssh {
  file { '.ssh/config':
    path   => "${::windows_env['USERPROFILE']}/.ssh/config",
    source => 'puppet:///modules/shell/ssh_config',
  }
}
