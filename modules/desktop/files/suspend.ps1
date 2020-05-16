Add-Type -AssemblyName System.Windows.Forms 
$PowerState = [System.Windows.Forms.PowerState]::Suspend
[System.Windows.Forms.Application]::SetSuspendState($PowerState, $false, $false)