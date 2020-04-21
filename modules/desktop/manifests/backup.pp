class desktop::backup {
  file { "${windows_env['USERPROFILE']}\\backup.bat":
    ensure  => file,
    content => lookup('desktop::backup::script_content')
  }
}
