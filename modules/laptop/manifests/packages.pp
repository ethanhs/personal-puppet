class laptop::packages {

  apt::key { 'vscode':
    id     => 'BC528686B50D79E339D3721CEB3E94ADBE1229CF',
    server => 'keyserver.ubuntu.com',
  }

  apt::source { 'vscode':
    architecture => 'amd64',
    location     => 'http://packages.microsoft.com/repos/vscode',
    release      => 'stable',
    repos        => 'main',
    require      => Apt::Key['vscode'],
  }

  apt::key { 'google':
    id     => 'EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796',
    source => 'https://dl-ssl.google.com/linux/linux_signing_key.pub';
  }

  # Chrome creates /etc/apt/sources.list.d/google-chrome.list upon
  # installation, so we use the name 'google-chrome' to avoid duplicates
  #
  # Chrome will overwrite the puppet apt source during install, but puppet
  # will later change it back. They say the same thing so it's cool.
  apt::source {
    'google-chrome':
      location => '[arch=amd64] http://dl.google.com/linux/chrome/deb/',
      release  => 'stable',
      repos    => 'main',
      require  => Apt::Key['google'];
  }

  apt::key {
    'llvm':
    id     => '6084F3CF814B57C1CF12EFD515CF4D18AF4F7421',
    source => 'https://apt.llvm.org/llvm-snapshot.gpg.key'
  }

  apt::source {
    'llvm-10':
    architecture => 'amd64',
    location     => 'http://apt.llvm.org/focal/',
    release      => 'llvm-toolchain-focal',
    repos        => 'main',
    include      => {
      'src' => true,
      'deb' => true,
    },
    require      => Apt::Key['llvm']
  }

  # General pacakges
  $packages = [
    # utilities
    'curl',
    'dos2unix',
    'graphviz',
    'smartmontools',
    'freerdp2-x11',
    'aria2',
    'git',
    'ripgrep',

    # Python
    'python3-venv',
    'python3-dev',
    'python3-dbg',

    # llvm/clang
    'clang',
    'clang-10',

    # c++
    'cmake',

    # editors
    'code',
    'vim',

    # media
    'vlc',
    'inkscape',
    'gimp',

    # deps
    'software-properties-common',

    # chat
    'telegram-desktop',
    'hexchat',

    # misc
    'gparted',
    'scrcpy',
  ]

  # TODO: more packages? https://github.com/ocf/puppet/blob/master/modules/ocf_desktop/manifests/packages.pp

  package { $packages:  ensure   => latest,  }

  # deps for various things
  $deps = [
    # git
    'libcurl4-openssl-dev', 'libssl-dev', 'zlib1g-dev',
    # cpython
    'libffi-dev',
    'libreadline-dev',
    'libsqlite3-dev',
    'ruby-dev',
    # opencl/pyopencl
    'python3-pyopencl',
    'nvidia-opencl-dev',
    # UniversalQ
    'uuid-dev',
    # plotinus
    'valac',
    'libgtk-3-dev',
    # scrs
    'libopenblas-dev',
    'libceres-dev'
  ]
  package { $deps: ensure => 'latest' }

  # debian packaging deps
  package {'aptitude': ensure => 'latest' }
  package {'devscripts': ensure => 'latest' }
  package {'git-buildpackage': ensure => 'latest' }

  $deadsnakes_pkgs = ['python3.7-dev', 'python3.8-dev', 'python3.9-dev']
  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { $deadsnakes_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }

  apt::ppa { 'ppa:unit193/encryption': } ->
  package { 'veracrypt':
    ensure  => latest,
    require => Exec['apt_update']
  }

  # TODO: graphics drivers
  # https://github.com/ocf/puppet/blob/master/modules/ocf_desktop/manifests/drivers.pp


  $snaps = ['spotify', 'discord', 'skype', 'signal-desktop']
  package { $snaps:
    ensure          => latest,
    provider        => snap,
    install_options => ['--classic'],
  }

}
