#NoTrayIcon  ; Hide tray icon, comment line to show tray icon 

; If executable is built locally, use that instead
if FileExist("target\release\tushar.exe")
    executable := "target\release\tushar.exe"
else if FileExist("..\Build\bin\Release\tushar.exe")
    executable := "..\Build\bin\Release\tushar.exe"
else
    executable := "tushar.exe"

; CTRL + J → Hide active window
^j::
{
    WinGetPID("A", pid)
    Run(executable " hide " pid,, "Hide")
    return
}

; CTRL + K → Unhide active window (tries to unhide all windows for this PID)
^k::
{
    WinGetPID("A", pid)
    Run(executable " unhide " pid,, "Hide")
    return
}

; CTRL + Q → Exit this script
^q::
{
    ExitApp
}
