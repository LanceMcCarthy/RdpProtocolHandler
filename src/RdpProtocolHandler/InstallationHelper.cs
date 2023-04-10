using Microsoft.Win32;
using NLog.Fluent;
using System;
using System.Reflection;
using System.Security.Principal;

namespace RdpProtocolHandler;

internal static class InstallationHelper
{
    internal static void Help()
    {
        ConsoleWrapper.Alloc();
        ConsoleWrapper.WriteLine("For help go to: https://github.com/LanceMcCarthy/RdpProtocolHandler");
    }

    internal static void Uninstall()
    {
        ConsoleWrapper.Alloc();

        if (!RequireAdministratorPrivileges()) 
            return;

        Registry.ClassesRoot.DeleteSubKeyTree(AppConstants.RegistryKeyName, false);
        ConsoleWrapper.WriteLine("RDP Protocol Handler uninstalled.");

        Log.Info("RDP Protocol Handler uninstalled.");
    }

    internal static void Install()
    {
        ConsoleWrapper.Alloc();

        if (!RequireAdministratorPrivileges()) 
            return;
        
        Uninstall();

        // Get assembly info
        var assembly = Assembly.GetExecutingAssembly();
        var handlerLocation = assembly.Location;

        // Create registry structure
        var rootKey = Registry.ClassesRoot.CreateSubKey(AppConstants.RegistryKeyName);
        var defaultIconKey = rootKey?.CreateSubKey("DefaultIcon");
        var commandKey = rootKey?.CreateSubKey("shell")?.CreateSubKey("open")?.CreateSubKey("command");

        rootKey?.SetValue("", "rdp:Remote Desktop Protocol");
        rootKey?.SetValue("URL Protocol", "");
        defaultIconKey?.SetValue("", AppConstants.MstscPath);
        commandKey?.SetValue("", $@"""{handlerLocation}"" ""%1""");

        // Write log and display output.
        Log.Info("RDP Protocol Handler installed");

        ConsoleWrapper.WriteLine("RDP Protocol Handler installed");
        ConsoleWrapper.WriteLine($"WARNING: Do not move this '{assembly.FullName}' to other location, otherwise handler will not work. If you change the location run installation process again.");
    }

    private static bool RequireAdministratorPrivileges()
    {
        var isAdmin = IsUserAdministrator();

        if (!isAdmin)
        {
            var oldColor = ConsoleWrapper.ForegroundColor;

            ConsoleWrapper.ForegroundColor = ConsoleColor.Red;
            ConsoleWrapper.WriteLine(AppConstants.MessageAdminRequired);
            ConsoleWrapper.ForegroundColor = oldColor;

            Log.Error(AppConstants.MessageAdminRequired);
        }

        return isAdmin;
    }

    private static bool IsUserAdministrator()
    {
        using var user = WindowsIdentity.GetCurrent();

        try
        {
            var principal = new WindowsPrincipal(user);

            return principal.IsInRole(WindowsBuiltInRole.Administrator);
        }
        catch (UnauthorizedAccessException)
        {
            return false;
        }
    }
}