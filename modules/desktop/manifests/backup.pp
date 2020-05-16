class desktop::backup {
  $backup_script = "${::windows_env['USERPROFILE']}\\backup.ps1"
  file { $backup_script:
    ensure  => file,
    content => lookup('desktop::backup::script_content')
  }

  scheduled_task { 'Backup':
    ensure    => 'present',
    command   => "$::system32\\WindowsPowerShell\\v1.0\\powershell.exe",
    arguments => '-File ${backup_script}',
    enabled   => 'true',
    trigger   => [{
      'schedule'         => 'weekly',
      'start_time'       => '06:00',
      'day_of_week'      => ['sun'],
    }],
    user      => 'system',
  }
}
