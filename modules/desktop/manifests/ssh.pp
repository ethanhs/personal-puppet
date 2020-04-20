class desktop::ssh {
  file { '.ssh/config':
    path   => "${::windows_env['USERPROFILE']}/.ssh/config",
    source => 'puppet:///modules/desktop/ssh_config',
  }

  file { '.ssh/config_rsync':
    path   => "${::windows_env['USERPROFILE']}/.ssh/config_rsync",
    source => 'puppet:///modules/desktop/ssh_config_rsync',
  }
}
