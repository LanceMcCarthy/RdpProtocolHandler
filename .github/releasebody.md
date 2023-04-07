## Installation

To install, use the following command with administrator rights.

`rdpProtocoleHandler.exe /install`

To uninstall:

`rdpProtocoleHandler.exe /uninstall`

**Important**: *Do not move the files after you've installed.* The handler's exe will be registered at its current path. If you need to move it, use the `/uninstall` command first, then move it and use the `/install` command again at the new location.

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
| With a username | `rdp://remote.server.address,/user:"username"` |
| With username and password | `rdp://remote.server.address,/user:"username-here",/pass:"password-here"` |
