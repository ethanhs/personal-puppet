class desktop::packages {
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

  $no_checksum = ['nvidia-display-driver']
  package { $no_checksum:
    ensure          => latest,
    provider        => 'chocolatey',
    install_options => ['--ignore-checksums'],
  }

  $desktop_packages = [

  ]

  package { $desktop_packages:
    ensure   => latest,
    provider => 'chocolatey',
  }
}