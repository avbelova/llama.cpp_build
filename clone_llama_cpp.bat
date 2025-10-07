@echo off
setlocal

:: Set repo details
set REPO_URL=https://github.com/ggerganov/llama.cpp.git
set REPO_DIR=llama.cpp
set TAG=b5598

echo ---------------------------------------
echo Cloning and building llama.cpp @ %TAG%
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

:: Fetch all tags
echo Fetching tags...
git fetch --all --tags

:: Checkout the specific tag
echo Checking out tag %TAG%...
git checkout tags/%TAG% -b build-%TAG%

echo ---------------------------------------

pause
