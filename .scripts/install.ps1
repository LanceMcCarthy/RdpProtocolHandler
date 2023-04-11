Write-Output "Checking for previous RdpProtocolHandler installation..."

if(Test-Path -Path "$($ENV:AppData)\Local\RdpProtocolHandler\RdpProtocolHandler.exe" -PathType Leaf) {
    Write-Output "Discovered older installation, uninstalling now..."

    $uninstallProcess = Start-Process "$($ENV:AppData)\Local\RdpProtocolHandler\RdpProtocolHandler.exe" -ArgumentList "/uinstall" -Verb RunAs -PassThru
    $uninstallProcess.WaitForExit()
}
else{
    Write-Output "RdpProtocolHandler was not previously installed, installing now..."

    Write-Output "Creating directory..."
    New-Item -ItemType "directory" -Path "$($ENV:AppData)\Local\RdpProtocolHandler" -Force
}

Write-Output "Copying files to installation directory..."
Copy-Item -Path ".\*" -Destination "$($ENV:AppData)\Local\RdpProtocolHandler" -Force

Write-Output "Changing to installation directory..."
Set-Location "$($ENV:AppData)\Local\RdpProtocolHandler"

Write-Output "Installing RdpProtocolHandler..."

$installProcess = Start-Process "$($ENV:AppData)\Local\RdpProtocolHandler\RdpProtocolHandler.exe" -ArgumentList "/install" -Verb RunAs -PassThru
$installProcess.WaitForExit()

Write-Output "Installation complete!"