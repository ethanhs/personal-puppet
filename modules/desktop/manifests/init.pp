class desktop {
  include desktop::explorer
  include desktop::packages
  include desktop::clink
  include desktop::all_repos
  include desktop::gpg
  include desktop::suspend
  include desktop::vcpkg
}
