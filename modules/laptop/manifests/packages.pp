class laptop::packages {
    package { 'throttlestop':
    ensure   => latest,
    provider => 'chocolatey',
  }
}
