; Inno Setup Script for Tushar - Lightweight Window Hiding Tool
; Generated for GitHub account: amJackma
; Website: https://github.com/amJackma/tushar

#define MyAppName "Tushar"
#define MyAppVersion "2.0.0"
#define MyAppPublisher "amJackma"
#define MyAppURL "https://github.com/amJackma/tushar"
#define MyAppExeName "tushar.exe"
#define MyLauncherName "tushar_launcher.ahk"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Generate new GUID with: Tools | Generate GUID in Inno Setup IDE
AppId={{A7C1E8F2-9B3D-4C5E-8F1A-2D6B9E3C5F8A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=no
OutputDir=releases\installer
OutputBaseFilename=Tushar-2.0.0-Installer
SetupIconFile=src-tauri\icons\invicon.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma
SolidCompression=yes

; Architecture settings
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

; Privileges
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "startup"; Description: "Launch {#MyAppName} on startup"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "releases\v2.0.0\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "releases\v2.0.0\{#MyLauncherName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}"; DestName: "README.txt"; Flags: ignoreversion
Source: ".gitignore"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyLauncherName}"; Comment: "Launch Tushar with keyboard shortcuts"
Name: "{group}\Uninstall {#MyAppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyLauncherName}"; Tasks: desktopicon; Comment: "Launch Tushar with keyboard shortcuts"

[Run]
Filename: "{app}\{#MyLauncherName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
Filename: "https://autohotkey.com/v2/"; Description: "Install AutoHotkey v2 (required for keyboard shortcuts)"; Flags: shellexec; Check: not IsAutoHotkey2Installed

[Code]
function IsAutoHotkey2Installed: Boolean;
var
  RegPath: String;
  Installed: Boolean;
begin
  if RegKeyExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\AutoHotkey') then
  begin
    Result := True;
  end
  else if RegKeyExists(HKEY_CURRENT_USER, 'SOFTWARE\AutoHotkey') then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

[Messages]
WelcomeLabel1=Welcome to the [name] Setup Wizard
WelcomeLabel2=This will install Tushar - a lightweight window hiding tool with keyboard shortcuts.%n%nTushar requires AutoHotkey v2 for keyboard shortcuts. You can install it from www.autohotkey.com if not already installed.%n%nClick Next to continue.

[CustomMessages]
LaunchProgram=Launch {#MyAppName}
CreateDesktopIcon=Create a &desktop shortcut
AdditionalIcons=Additional icons:
