class laptop {
    include laptop::all_repos
    include laptop::git
    include laptop::gpg
    include laptop::packages
    include laptop::yubikey
    include laptop::docker
    include laptop::xfreerdp
    include laptop::ssh
    class { 'unattended_upgrades':
      mail => { 'to' => 'ethan@ethanhs.me', },
    }

}
