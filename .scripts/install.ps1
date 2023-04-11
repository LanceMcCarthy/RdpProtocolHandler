$thisProcess = Start-Process "$psHome\powershell.exe" -Verb Runas -ArgumentList '-command "Get-Service"'

Write-Output "Checking for previous RdpProtocolHandler installation..."

$result = Get-Item "C:\Program Files\Lancelot Software\RdpProtocolHandler\*.*"

if($null -ne $result) {
    Write-Output "Checking for previous RdpProtocolHandler installation..."
    $uninstallProcess = Start-Process ".\RdpProtocolHandler.exe" -ArgumentList "/uinstall" -Verb RunAs -PassThru
    $uninstallProcess.WaitForExit()
    
    Write-Output "Creating directory..."
    New-Item -ItemType "directory" -Path "C:\Program Files\Lancelot Software\RdpProtocolHandler" -Force
}
else{
    Write-Output "RdpProtocolHandler was not installed, moving forward with installation."
}

Write-Output "Copying files to installation directory..."
Copy-Item -Path ".\*" -Destination "C:\Program Files\Lancelot Software\RdpProtocolHandler" -Force

Write-Output "Changing to installation directory..."
Set-Location "C:\Program Files\RdpProtocolHandler"

Write-Output "Installing RdpProtocolHandler..."

$installProcess = Start-Process ".\RdpProtocolHandler.exe" -ArgumentList "/install" -Verb RunAs -PassThru
$installProcess.WaitForExit()

Stop-Process $thisProcess.ID