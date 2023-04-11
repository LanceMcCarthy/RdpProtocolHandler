$thisProcess = Start-Process "$psHome\powershell.exe" -Verb Runas -ArgumentList '-command "Get-Service"'

Write-Output "Verifying current installation..."

$result = Get-Item "C:\Program Files\Lancelot Software\RdpProtocolHandler\*.*"

if($null -ne $result) {
    Write-Output "Uninstalling RdpProtocolHandler..."
    $uninstallProcess = Start-Process ".\RdpProtocolHandler.exe" -ArgumentList "/uninstall" -Verb RunAs -PassThru
    $uninstallProcess.WaitForExit()
}
else{
    Write-Output "RdpProtocolHandler was not installed."
}

Write-Output "Uninstall complete!"

Stop-Process $thisProcess.ID