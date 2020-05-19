class desktop::vcpkg {
  vcsrepo { "${::windows_env['USERPROFILE']}/vcpkg":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/Microsoft/vcpkg.git',
  }

  exec { 'Install vcpkg':
    command  => "${::windows_env['USERPROFILE']}/vcpkg/bootstrap-vcpkg.bat",
    unless   => "if(![System.IO.File]::Exists(${::windows_env['USERPROFILE']}/vcpkg/vcpkg.exe)){exit 1}",
    provider => powershell,
  }

  exec { 'Integrate vcpkg':
    command  => "${::windows_env['USERPROFILE']}/vcpkg/vcpkg.exe integrate install",
    provider => powershell,
  }


}
