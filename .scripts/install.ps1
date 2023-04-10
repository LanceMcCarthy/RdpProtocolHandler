Start-Process "$psHome\powershell.exe" -Verb Runas -ArgumentList '-command "Get-Service"'

Write-Output "Checking for previous RdpProtocolHandler installation..."

$result = Get-Item "C:\Program Files\RdpProtocolHandler\*.*"

if($null -ne $result) {
    Write-Output "Checking for previous RdpProtocolHandler installation..."
    Start-Process ".\RdpProtocolHandler.exe" -ArgumentList "/uinstall" -Wait
}
else{
    Write-Output "RdpProtocolHandler was not installed, moving forward with installation."
}

Write-Output "Creating directory..."
New-Item -ItemType "directory" -Path "C:\Program Files\RdpProtocolHandler" -Force

Write-Output "Copying files to installation directory..."
Copy-Item -Path ".\*" -Destination "C:\Program Files\RdpProtocolHandler" -Force

Write-Output "Changing to installation directory..."
Set-Location "C:\Program Files\RdpProtocolHandler"

Write-Output "Installing RdpProtocolHandler..."
Start-Process ".\RdpProtocolHandler.exe" -ArgumentList "/install" -Wait

Write-Output "Done!"