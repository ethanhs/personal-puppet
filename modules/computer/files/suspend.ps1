Add-Type -AssemblyName System.Windows.Forms
$PowerState = [System.Windows.Forms.PowerState]::Suspend
$wshell = New-Object -ComObject Wscript.Shell
$answer = $wshell.Popup("Do you want to suspend?",10,"Question",32+4)
if ($answer -ne 7) {
    [System.Windows.Forms.Application]::SetSuspendState($PowerState, $false, $false)
}
