class laptop {
    include laptop::all_repos
    include laptop::git
    include laptop::gpg
    include laptop::packages
    include laptop::yubikey
    class { 'apt':
      update => {
      frequency => 'daily',
    },
}
}
