@echo off
setlocal

:: Set repo details
set REPO_URL=https://github.com/ggerganov/llama.cpp.git
set REPO_DIR=llama.cpp
set TAG=b5598

echo ---------------------------------------
echo Building llama.cpp @ %TAG% with CPU backend
echo ---------------------------------------

:: Change to the directory
cd %REPO_DIR%

:: Fetch all tags
echo Fetching tags...
git fetch --all --tags

:: Checkout the specific tag
echo Checking out tag %TAG%...
git checkout tags/%TAG% -b build-%TAG%

:: Building for CPU
cmake -B build-%TAG%-cpu -DLLAMA_CURL=OFF
cmake --build build-%TAG%-cpu --config Release -j 8

echo ---------------------------------------
echo Build complete for llama.cpp @ %TAG%
echo Output is in: %cd%
echo ---------------------------------------

pause
