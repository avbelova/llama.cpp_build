@echo off
setlocal

:: Set repo details
set REPO_DIR=llama.cpp

echo ---------------------------------------
echo Building llama.cpp with CPU backend
echo ---------------------------------------

:: Change to the directory
cd %REPO_DIR%

:: Building for CPU
cmake -B build-cpu -DLLAMA_CURL=OFF
cmake --build build-cpu --config Release -j 8

echo ---------------------------------------
echo Build complete for llama.cpp
echo Output is in: %cd%
echo ---------------------------------------

pause

