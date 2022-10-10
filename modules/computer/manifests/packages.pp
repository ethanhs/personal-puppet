class computer::packages {
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

  # Python 3 is pre-req to puppet running, so it is in setup-puppet

  # Install openssh with the ssh-server functionality on
  package { 'openssh':
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-installArgs', '"', '/SSHServerFeature', '"'],
  }

  package { 'firefox-nightly':
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['-pre', '-installArgs', '"', '/S', '/DesktopShortcut=false', '/TaskbarShortcut=false', '/AutoUpdate=false', '"'],
  }

  $no_checksum = ['spotify']
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

  package { 'Install Rust':
    ensure          => installed,
    source          => "C:\\temp\\rustup-init.exe",
    install_options => ['--default-host=x86_64-pc-windows-msvc', '--default-toolchain=nightly', '-y']
  } ~> download_file { 'Download rustup' :
    url                   => 'https://win.rustup.rs/x86_64',
    destination_directory => 'c:\\temp',
    destination_file      => 'rustup-init.exe'
  }

  exec { 'uninstall unwanted apps':
    command  => file('computer/uninstall_apps.ps1'),
    onlyif   => file('computer/check_installed.ps1'),
    provider => powershell
  }

  $all_other_packages = [
    '7zip',
    'aria2',
    'cmake',
    'cpu-z',
    'crystaldiskinfo',
    'crystaldiskmark',
    'rsync',
    'dejavufonts',
    'deluge',
    'discord',
    'docker-desktop',
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
    'openhardwaremonitor',
    'OpenSSL.Light',
    'openvpn',
    'pulseaudio',
    'putty',
    'rclone',
    'restic',
    'ripgrep',
    'rufus',
    'scrcpy',
    'sharex',
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
    'yubikey-manager',
  ]

  package { $all_other_packages:
    ensure   => latest,
    provider => 'chocolatey',
  }

}
