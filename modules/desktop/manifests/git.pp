class desktop::git {
  file { '.gitconfig':
    path   => "${::windows_env['USERPROFILE']}/.gitconfig",
    source => 'puppet:///modules/desktop/.gitconfig',
  }
}
