class desktop::env {
  windows_env { 'Workaround MKL being dumb':
    ensure   => present,
    variable => 'MKL_DEBUG_CPU_TYPE',
    value    => '5'
  }
}
