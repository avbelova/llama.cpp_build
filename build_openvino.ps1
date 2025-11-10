# Run this in Developer PowerShell for Visual Studio 2022

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

set REPO_URL=https://github.com/ravi9/llama.cpp.git
set REPO_DIR=llama.cpp
Set-Location "llama.cpp"
$here = Get-Location

if (-not (Test-Path $env:REPO_DIR)) {
    Write-Host "Cloning llama.cpp..."
    git clone $env:REPO_URL
} else {
    Write-Host "llama.cpp already exists. Skipping clone."
}

Write-Host "=== Setting up OpenVINO environment ==="
Set-Location "C:\Program Files (x86)\Intel\openvino_2025.3.0\"
.\setupvars.ps1

Set-Location $here

Write-Host "=== Switching to branch dev_backend_openvino ==="
git switch dev_backend_openvino

Write-Host "=== Configuring CMake build with OpenVINO ==="
cmake -B build\ReleaseOV `
    -DCMAKE_BUILD_TYPE=Release `
    -DGGML_OPENVINO=ON `
    -DGGML_CPU_REPACK=OFF `
    -DLLAMA_CURL=OFF

if ($LASTEXITCODE -ne 0) {
    Write-Error "CMake configuration failed."
    exit 1
}

Write-Host "=== Building project ==="
$jobs = [Environment]::ProcessorCount
cmake --build build\ReleaseOV --config Release -j $jobs

if ($LASTEXITCODE -eq 0) {
    Write-Host "=== Build completed successfully! ==="
} else {
    Write-Error "Build failed."
    exit 1
}