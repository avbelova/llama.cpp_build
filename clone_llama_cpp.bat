@echo off
setlocal

:: Set repo details
set REPO_URL=https://github.com/ravi9/llama.cpp.git
set REPO_DIR=llama.cpp

echo ---------------------------------------
echo Cloning and building llama.cpp
echo ---------------------------------------

:: Clone the repo if it doesn't exist
if not exist "%REPO_DIR%" (
    echo Cloning llama.cpp...
    git clone %REPO_URL%
) else (
    echo llama.cpp already exists. Skipping clone.
)

:: Change to the directory
cd %REPO_DIR%

:: Switching to dev_backend_openvino branch
git switch dev_backend_openvino

echo ---------------------------------------

pause
