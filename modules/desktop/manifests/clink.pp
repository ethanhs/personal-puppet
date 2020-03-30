class desktop::clink {
  registry_value { 'HKLM\\Software\\Microsoft\\Command Processor\\Autorun':
    ensure => present,
    type   => string,
    data   => "\"C:\\Program Files (x86)\\clink\\0.4.9\\clink.bat\" inject --autorun --quiet --profile ~\\clink",
  }


  exec { 'checkout clink-completions':
    command  => "cd ${::windows_env['LOCALAPPDATA']}/clink ; git init ; git remote add origin https://github.com/vladimir-kotikov/clink-completions ; git pull origin master",
    onlyif   => "-not [System.IO.File]::Exists(\"${::windows_env['LOCALAPPDATA']}/clink/.git\")",
    provider => powershell,
  }

  package {
    'clink':
    ensure   => latest,
    provider => 'chocolatey',
  }

  file { 'git_prompt.lua':
    path   => "${::windows_env['LOCALAPPDATA']}/clink/git_prompt.lua",
    source => 'puppet:///modules/desktop/git_prompt.lua',
  }
}
