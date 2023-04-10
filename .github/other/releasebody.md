## Automatic Installation (recommended)

Execute the `install.ps1` / `uninstall.ps1` to install/uninstall the protocol handler.

This will automatically install the handler at a common location: *C:/Program Files/RdpProtocolHandler/*.

## Manual Installation

Open Windows Terminal (or plain PowerShell), as administrator, in the same directory as RdpProtocoleHandler.exe and use the desired command:

| Command | Action |
|---------|-----|
| `.\RdpProtocoleHandler.exe /install` | Install |
| `.\RdpProtocoleHandler.exe /uninstall` | Uninstall |

**Important: Do not move the files after you've installed.** The handler's exe will be registered at its current path. If you need to move it, use the `/uninstall` command first, then move it to the new location reinstall it. The 

## Usage

Open a uri that starts with `rdp://` using a web browser (or any other way). The uri will be parsed by the handler like this:

`rdp://<remote.server.address>,<param1>,<param2>,...`

Each parameter in the uri is separated by comma `,` and the first parameter is always the remote server address. The parameters are the same ones for mstsc.exe, see a full list here [https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mstsc](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mstsc).

## Examples

| Example | uri |
|---------|-----|
| Basic | `rdp://remote.server.address` |
| With a specific window dimensions | `rdp://remote.server.address,/w:600,/h:400` |
| using all monitors | `rdp://remote.server.address,/multimon` |

Note: Password and username variables are not available for mstsc. You will get a prompt the first time you connect to a machine. If you have previous connected and store credentials, this will be skipped
