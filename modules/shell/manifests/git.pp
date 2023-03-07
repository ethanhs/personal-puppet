class shell::git {
  file { '.gitconfig':
    path   => "${facts['windows_env']['USERPROFILE']}/.gitconfig",
    source => 'puppet:///modules/shell/.gitconfig',
  }
}
