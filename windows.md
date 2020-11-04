This document captures steps for setting up a new Windows 10 install.

## Prerequisites

* Fresh install of Windows 10
* Internet access

## Script

Run the following commands (one by one if desired) in PowerShell with admin priveleges.

```powershell
# Change computer name
Rename-Computer -NewName "parshap10"

# ## Explorer settings
# Show hidden files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
# Show "super hidden" files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f
# Show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
# Don't pretty print paths
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DontPrettyPath /t REG_DWORD /d 1 /f
# Show full paths
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f
# Show full paths in address bar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPathAddress /t REG_DWORD /d 1 /f

# Keyboard repeat speed and delay
reg add "HKCU\Control Panel\Keyboard" /f /v "KeyboardSpeed" /t REG_SZ /d 31
reg add "HKCU\Control Panel\Keyboard" /f /v "KeyboardDelay" /t REG_SZ /d 0

# Make desktop background black
reg add "HKCU\Control Panel\Desktop" /v WallPaper /t REG_SZ /d " " /f
reg add "HKCU\Control Panel\Colors" /v Background /t REG_SZ /d "0 0 0" /f

# Remove search from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
# Remove Task View icon from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

# Enable hyper-v
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install software using Chocolatey
choco install git gh kitty googlechrome firefox discord zoom licecap nodejs vagrant

# Restart
Restart-Computer
```

## Configure KiTTY

https://blog.cochard.me/2014/09/putty-and-solarized-colors.html

## Future consideration

* https://boxstarter.org/WhyBoxstarter
