class desktop::packages {
  include chocolatey

  # Git is essential
  package { 'git':
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-installArgs', '"', '/GitAndUnixToolsOnPath', '/WindowsTerminal', '"'],
  }

  # Everything search because Windows search sucks. The service works better IME.
  package { 'everything':
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-installArgs', '"', '/client-service', '/efu-association', '/folder-context-menu', '"'],
  }

  # Install a minimal Python 2, installing just the Tools
  # (not added to the path or registering for *.py)
  # The names for this were not easy to find documentation for
  # All I could find for the MSI customization arguments was
  # https://www.python.org/download/releases/2.4/msi/
  package { 'python2':
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-installArgs', '"', 'ADDLOCAL=Tools', '"'],
  }

  # Python 3 is pre-req to puppet running, so it is in setup-puppet

  # Install openssh with the ssh-server functionality on
  package { 'openssh':
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-installArgs', '"', '/SSHServerFeature', '"'],
  }

  # now install all the Visual Studio stuff
  package { 'visualstudio2019community':
    ensure   => latest,
    provider => 'chocolatey',
  }

  # these extensions don't need to be customized
  $vs_extensions = [
    'visualstudio2019-workload-visualstudioextension',
    'visualstudio2019-workload-nativedesktop',
    'visualstudio2019-workload-nativecrossplat',
    'visualstudio2019-workload-data'
  ]
  package { $vs_extensions:
    ensure   => latest,
    provider => 'chocolatey',
  }

  # these do need args
  $vs_extensions_with_opt = ['visualstudio2019-workload-netcoretools', 'visualstudio2019-workload-manageddesktop']
  package { $vs_extensions_with_opt:
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-installArgs', '"', '--includeOptional', '"'],
  }

  package { 'firefox-nightly':
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-pre', '-installArgs', '"', '/S', '/DesktopShortcut=false', '/TaskbarShortcut=false', '/AutoUpdate=false', '"'],
  }

  $no_checksum = ['nvidia-display-driver', 'spotify']
  package { $no_checksum:
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['--ignore-checksums'],
  }

  $windows_features = ['Microsoft-Hyper-V-All', 'Microsoft-Windows-Subsystem-Linux']
  package { $windows_features:
    ensure          => installed,
    provider        => chocolatey,
    install_options => ['-source', 'windowsfeatures']
  }

  download_file { 'Download rustup' :
    url                   => 'https://win.rustup.rs/x86_64',
    destination_directory => 'c:\\temp',
    destination_file      => 'rustup-init.exe'
  }

  package { 'Install Rust':
    ensure          => installed,
    source          => "C:\\temp\\rustup-init.exe",
    install_options => ['--default-host=x86_64-pc-windows-msvc', '--default-toolchain=nightly', '-y']
  }

  download_file { 'Download Zerotier' :
    url                   => 'https://download.zerotier.com/dist/ZeroTier%20One.msi',
    destination_directory => 'c:\\temp',
    destination_file      => 'ZeroTierOne.msi'
  }

  package { 'ZeroTier One':
    ensure => installed,
    source => "C:\\temp\\ZeroTierOne.msi"
  }

  exec { 'uninstall unwanted apps':
    command  => file('desktop/uninstall_apps.ps1'),
    onlyif   => file('desktop/check_installed.ps1'),
    provider => powershell
  }

  $all_other_packages = [
    '7zip',
    'adb',
    'androidstudio',
    'aria2',
    'blender',
    'bonjour',
    'cmake',
    'cpu-z',
    'crystaldiskinfo',
    'crystaldiskmark',
    'cuda',
    'rsync',
    'Cygwin',
    'dejavufonts',
    'deluge',
    'discord',
    'docker-desktop',
    'docker-for-windows',
    'dolphin',
    'dosbox',
    'DotNet4.5',
    'DotNet4.5.2',
    'DotNet4.6',
    'DotNet4.6-TargetPack',
    'DotNet4.6.1',
    'dotnet4.6.2',
    'ext2fsd',
    'fd',
    'ffmpeg',
    'fzf',
    'gh',
    'gimp',
    'GoogleChrome',
    'gpg4win',
    'gsmartcontrol',
    'hexchat',
    'hwinfo',
    'imdisk-toolkit',
    'InkScape',
    'jq',
    'keepassxc',
    'llvm',
    'lockhunter',
    'neovim',
    'netfx-4.5.1-devpack',
    'netfx-4.5.2-devpack',
    'netfx-4.6.1-devpack',
    'ninja',
    'nmap',
    'nsis-unicode',
    'nvm',
    'obs-studio',
    'openhardwaremonitor',
    'OpenSSL.Light',
    'openvpn',
    'pulseaudio',
    'putty',
    'rclone',
    'Recuva',
    'restic',
    'riot-web',
    'ripgrep',
    'rufus',
    'scrcpy',
    'sharex',
    'sidesync',
    'steam',
    'strawberryperl',
    'sysinternals',
    'vcredist140',
    'vcredist2008',
    'vcredist2013',
    'vcredist2015',
    'vcredist2017',
    'veracrypt',
    'vlc',
    'vscode',
    'vscode-docker',
    'windirstat',
    'wireshark',
    'wsltty',
    'yubikey-manager',
    'zadig',
  ]

  package { $all_other_packages:
    ensure   => latest,
    provider => 'chocolatey',
  }

}
