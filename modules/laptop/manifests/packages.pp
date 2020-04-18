class laptop::packages {
    # General pacakges
    $packages = [
      'curl',
      'dos2unix',
      'graphviz',

      'python3-venv',
      'python3-dev',
      'python3-dbg',
      'vim',
      'vlc',
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
    ]
    package { $deps: ensure => 'latest' }

    # debian packaging deps
    package {'aptitude': ensure => 'latest' }
    package {'devscripts': ensure => 'latest' }
    package {'git-buildpackage': ensure => 'latest' }

    # TODO: docker https://github.com/asottile/personal-puppet/blob/master/modules/packages/manifests/docker.pp
    # TODO: deadsnakes https://github.com/asottile/personal-puppet/blob/master/modules/packages/manifests/python.pp
    #apt::ppa { 'ppa:deadsnakes/ppa': }

    # TODO: graphics drivers
    # https://github.com/ocf/puppet/blob/master/modules/ocf_desktop/manifests/drivers.pp

    # TODO: use OCF apt? or another one? https://github.com/ocf/puppet/blob/4e37cbedd228d89bc2f32234dbb4fc54114faa9d/modules/ocf/manifests/apt.pp
    # TODO: LLVM apt

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
}
