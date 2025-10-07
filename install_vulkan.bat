@echo off
setlocal

REM --- Vulkan SDK version and download URL ---
set "VULKAN_VERSION=1.3.283.0"
set "VULKAN_PLATFORM=windows"
set "VULKAN_INSTALLER=VulkanSDK-%VULKAN_VERSION%-Installer.exe"
set "VULKAN_URL=https://sdk.lunarg.com/sdk/download/%VULKAN_VERSION%/%VULKAN_PLATFORM%/%VULKAN_INSTALLER%"
echo %VULKAN_URL%


IF NOT EXIST "%VULKAN_INSTALLER%" (
    echo Downloading Vulkan SDK %VULKAN_VERSION%...
    powershell -Command "Invoke-WebRequest -Uri '%VULKAN_URL%' -OutFile '%VULKAN_INSTALLER%'"

)

echo Please folllow Vulkan installer installation steps ...
"%VULKAN_INSTALLER%" /S

endlocal
pause

