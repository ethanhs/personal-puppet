class shell::clink {
  exec { 'checkout clink-completions':
    command  => "cd ${facts['windows_env']['LOCALAPPDATA']}/clink ; git init ; git remote add origin https://github.com/vladimir-kotikov/clink-completions ; git pull origin master",
    onlyif   => "-not [System.IO.File]::Exists(\"${facts['windows_env']['LOCALAPPDATA']}/clink/.git\")",
    provider => powershell,
  }

  package {
    'clink':
    ensure   => absent,
    provider => 'chocolatey',
  }

  file { 'git_prompt.lua':
    path   => "${facts['windows_env']['LOCALAPPDATA']}/clink/git_prompt.lua",
    source => 'puppet:///modules/shell/git_prompt.lua',
  }
}
