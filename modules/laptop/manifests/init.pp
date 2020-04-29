class laptop {
    include laptop::all_repos
    include laptop::git
    include laptop::gpg
    include laptop::packages
    include laptop::yubikey
    include laptop::docker
    class { 'apt':
      update => {
      frequency => 'daily',
    },
}
}
