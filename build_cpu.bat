@echo off
setlocal

:: Set repo details
set REPO_URL=https://github.com/ravi9/llama.cpp.git
set REPO_DIR=llama.cpp

:: Clone the repo if it doesn't exist
if not exist "%REPO_DIR%" (
    echo Cloning llama.cpp...
    git clone %REPO_URL%
) else (
    echo llama.cpp already exists. Skipping clone.
)

echo ---------------------------------------
echo Building llama.cpp with CPU backend
echo ---------------------------------------

:: Change to the directory
cd %REPO_DIR%
git switch dev_backend_openvino

:: Building for CPU
cmake -B build-cpu -DLLAMA_CURL=OFF
cmake --build build-cpu --config Release -j 8

echo ---------------------------------------
echo Build complete for llama.cpp
echo Output is in: %cd%
echo ---------------------------------------

pause

