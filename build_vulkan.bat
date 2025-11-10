@echo off
setlocal enabledelayedexpansion

set REPO_URL=https://github.com/ravi9/llama.cpp.git
set REPO_DIR=llama.cpp

:: Clone the repo if it doesn't exist
if not exist "%REPO_DIR%" (
    echo Cloning llama.cpp...
    git clone %REPO_URL%
) else (
    echo llama.cpp already exists. Skipping clone.
)

:: Set versions and URLs
set SDK_VERSION=1.3.283.0
set W64DEVKIT_URL=https://github.com/skeeto/w64devkit/releases/download/v2.4.0/w64devkit-x64-2.4.0.7z.exe

:: Set install locations
set CURRENT_DIR=%CD%
set W64DEVKIT_DIR=%CURRENT_DIR%\w64devkit
set VULKAN_SDK_DIR=C:\VulkanSDK\1.3.283.0
set PATH=%VULKAN_SDK_DIR%;%PATH%

if not exist "%VULKAN_SDK_DIR%" (
    echo Please install VULKAN SDK 1.3.283.0.
    exit /b 1
)

if not exist "%W64DEVKIT_DIR%" (
    echo Downloading and extracting w64devkit...
    curl -L -o w64devkit.zip %W64DEVKIT_URL%
    tar -xf w64devkit.zip
)

:: Adding w64devkit to the path
set PATH=%W64DEVKIT_DIR%\bin;%PATH%

echo Copying Vulkan dependencies to w64devkit...

:: Ensure required folders exist
mkdir "%W64DEVKIT_DIR%\x86_64-w64-mingw32\lib\pkgconfig" 2>nul

copy "%VULKAN_SDK_DIR%\Bin\glslc.exe" "%W64DEVKIT_DIR%\bin\"
copy "%VULKAN_SDK_DIR%\Lib\vulkan-1.lib" "%W64DEVKIT_DIR%\x86_64-w64-mingw32\lib\"
xcopy "%VULKAN_SDK_DIR%\Include\" "%W64DEVKIT_DIR%\x86_64-w64-mingw32\include\" /E /I /Y

echo Creating pkg-config file...
(
echo Name: Vulkan-Loader
echo Description: Vulkan Loader
echo Version: %SDK_VERSION%
echo Libs: -lvulkan-1
) > "%W64DEVKIT_DIR%\x86_64-w64-mingw32\lib\pkgconfig\vulkan.pc"

echo Building llama.cpp with Vulkan...

:: Change to llama.cpp directory
cd %REPO_DIR%
git switch dev_backend_openvino

echo Run CMake build inside w64devkit
cmake -B build_vulkan -DGGML_VULKAN=ON -DLLAMA_CURL=OFF
cmake --build build_vulkan --config Release -j %NUMBER_OF_PROCESSORS%

echo ---------------------------------------
echo Build complete for llama.cpp
echo ---------------------------------------

echo Done.
pause