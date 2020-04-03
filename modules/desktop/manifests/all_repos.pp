class desktop::all_repos {
  $all_repos_config_path = "C:\\Users\\ethanhs\\.all_repos\\all_repos.json"
  windows_env { 'all repos config path':
    ensure    => present,
    variable  => 'ALL_REPOS_CONFIG_FILENAME',
    value     => $all_repos_config_path
  }

  file { $all_repos_config_path:
    ensure  => file,
    content => lookup('desktop::all_repos::config_file_content')
  }

}
