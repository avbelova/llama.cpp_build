@echo off
title Intel oneAPI Base Toolkit Installer
setlocal enabledelayedexpansion

echo ======================================================
echo     Intel oneAPI Base Toolkit Silent Installer
echo ======================================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run this script as Administrator.
    pause
    exit /b 1
)

:: Set download URL and destination
set "ONEAPI_URL=https://registrationcenter-download.intel.com/akdlm/IRC_NAS/f5881e61-dcdc-40f1-9bd9-717081ac623c/intel-oneapi-base-toolkit-2025.2.1.46_offline.exe"
set "INSTALLER_PATH=oneAPI_BaseKit_Installer.exe"
set "INSTALL_DIR=C:\Program Files (x86)\Intel\oneAPI"

echo Downloading Intel oneAPI Base Toolkit installer...
powershell -Command "Invoke-WebRequest -Uri '%ONEAPI_URL%' -OutFile '%INSTALLER_PATH%'"
if %errorLevel% neq 0 (
    echo [ERROR] Failed to download the installer.
    pause
    exit /b 1
)
echo Download complete.

echo.
echo Installing Intel oneAPI Base Toolkit silently...
"%INSTALLER_PATH%" --silent --eula=accept --install-dir="%INSTALL_DIR%"
if %errorLevel% neq 0 (
    echo [ERROR] Installation failed.
    pause
    exit /b 1
)
echo Installation complete.

:: Optional: Add oneAPI environment setup to user profile
set "SETVARS_PATH=%INSTALL_DIR%\setvars.bat"
if exist "%SETVARS_PATH%" (
    echo Adding oneAPI environment setup to PowerShell profile...
    powershell -Command "Add-Content -Path $PROFILE -Value ('`ncmd /c ""%SETVARS_PATH%""')"
    echo Added successfully.
) else (
    echo [WARNING] Could not find setvars.bat; please verify installation.
)

echo.
echo ======================================================
echo Intel oneAPI Base Toolkit installation completed!
echo To use oneAPI, open a new PowerShell window and run:
echo    cmd /c "%SETVARS_PATH%"
echo ======================================================
pause
exit /b 0