class desktop::suspend {
  $suspend_script = "${::windows_env['LOCALAPPDATA']}/personal-scripts/suspend.ps1"

  file { "${::windows_env['LOCALAPPDATA']}/personal-scripts":
    ensure => 'directory',
  }

  file { 'suspend.ps1':
    path   => $suspend_script,
    source => 'puppet:///modules/desktop/suspend.ps1',
  }

  scheduled_task { 'Suspend in the morning':
    ensure    => 'present',
    command   => "${::system32}\\WindowsPowerShell\\v1.0\\powershell.exe",
    arguments => "-File ${suspend_script}",
    enabled   => 'true',
    trigger   => [{
      'schedule'   => 'daily',
      'start_time' => '06:00',
    }],
    user      => 'system',
  }
}
