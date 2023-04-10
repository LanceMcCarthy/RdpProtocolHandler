Start-Process "$psHome\powershell.exe" -Verb Runas -ArgumentList '-command "Get-Service"'

Write-Output "Verifying current installation..."

$result = Get-Item "C:\Program Files\RdpProtocolHandler\*.*"

if($null -ne $result) {
    Write-Output "Uninstalling RdpProtocolHandler..."
    Start-Process ".\RdpProtocolHandler.exe" -ArgumentList "/uinstall" -Wait
}
else{
    Write-Output "RdpProtocolHandler was not installed."
}

Write-Output "Uninstall complete!"