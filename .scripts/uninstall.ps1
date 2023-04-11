Write-Output "Verifying current installation..."

$result = Get-Item "$($ENV:AppData)\Local\RdpProtocolHandler\*.*"

if($null -ne $result) {
    Write-Output "Uninstalling RdpProtocolHandler..."
    $uninstallProcess = Start-Process "$($ENV:AppData)\Local\RdpProtocolHandler\RdpProtocolHandler.exe" -ArgumentList "/uninstall" -Verb RunAs -PassThru
    $uninstallProcess.WaitForExit()
}
else{
    Write-Output "RdpProtocolHandler was not installed."
}

Write-Output "Uninstall complete!"