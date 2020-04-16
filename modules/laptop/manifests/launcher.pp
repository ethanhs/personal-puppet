class laptop::launcher {
  gsetting { 'org.gnome.shell favorite-apps':
    ensure => [
      'firefox.desktop',
      'org.gnome.Nautilus.desktop',
      'org.gnome.Terminal.desktop',
    ],
    user   => 'ethanhs',
  }
  gsetting { 'org.gnome.shell.extensions.dash-to-dock multi-monitor':
    ensure => ':true',
    user   => 'ethanhs',
  }
}
