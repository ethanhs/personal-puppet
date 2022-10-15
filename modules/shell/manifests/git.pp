class shell::git {
  file { '.gitconfig':
    path   => "${::windows_env['USERPROFILE']}/.gitconfig",
    source => 'puppet:///modules/shell/.gitconfig',
  }
}
