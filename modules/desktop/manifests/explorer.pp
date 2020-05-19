# Configure Explorer/Windows Shell to show hidden files, etc.

class desktop::explorer {

  # Show hidden files
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\Hidden':
    ensure => present,
    type   => dword,
    data   => 1,
  }

  # Show file extensions
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\HideFileExt':
    ensure => present,
    type   => dword,
    data   => 0,
  }

  # Don't include public folders in search
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\Start_SearchFiles':
    ensure => present,
    type   => dword,
    data   => 1,
  }

  # needed for the Cortana removal below
  registry_key { 'HKLM\\Software\\Policies\\Microsoft\\Windows\\Windows Search':
    ensure => present,
  }

  # disable Cortana
  registry_value { 'HKLM\\Software\\Policies\\Microsoft\\Windows\\Windows Search\\Allow Cortana':
    ensure => present,
    type   => dword,
    data   => 0,
  }

  # Allow sideloading UWP apps
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\AppModelUnlock\\AllowDevelopmentWithoutDevLicense':
    ensure => present,
    type   => dword,
    data   => 1,
  }

  # Open in current folder
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\NavPaneExpandToCurrentFolder':
    ensure => present,
    type   => dword,
    data   => 1,
  }

  # Show all folders
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\NavPaneShowAllFolders':
    ensure => present,
    type   => dword,
    data   => 1,
  }

  # Open This PC instead of Quick Access
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\LaunchTo':
    ensure => present,
    type   => dword,
    data   => 1,
  }

  # Show window taskbar icon on taskbar the window is on
  registry_value { 'HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\MMTaskbarMode':
    ensure => present,
    type   => dword,
    data   => 2,
  }

  # Stop Explorer while we change a few things
  exec { 'stop explorer':
    command  => 'Stop-Process -processname explorer',
    unless   => "Get-ItemProperty -Path HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced -Name PuppetRan",
    provider => powershell,
  }

  registry_value { 'HKLM\\Software\\\\Windows\\CurrentVersion\\Explorer\\Advanced\\PuppetRan':
    ensure => present,
    type   => dword,
    data   => 1,
  }
}
