namespace RdpProtocolHandler;

public static class AppConstants
{
    public const string RegistryKeyName = "RDP";
    public const string Kernel32DllName = "kernel32.dll";

    public const string MstscPath = @"C:\Windows\System32\mstsc.exe";

    public const string CommandInstall = @"/install";
    public const string CommandUninstall = @"/uninstall";
    public const string CommandLog = @"/log";
    public const string CommandHelp = @"/help";
    public const string CommandQuestion = @"/?";

    
    public const string MessageAdminRequired = @"You must be system administrator";
}