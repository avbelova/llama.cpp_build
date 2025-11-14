# llama.cpp_build
Here you can find scripts and instructions how to build llama.cpp with diferent backends: CPU, VULKAN, SYCL, OpenVINO.

Usage instructions:
```
git clone https://github.com/avbelova/llama.cpp_build.git
cd llama.cpp_build
```
## CPU
### Windows
```
build_cpu.bat
```
### Linux
```
build_cpu.sh
```
## GPU-VULKAN
### Windows
Install VULKAN SDK. The following script downloads VULKAN SDK installer and runs it. Please follow the installer steps manually.
```
install_vulkan.bat
```
Build
```
build_vulkan.bat
```
### Linux
```
install_vulkan.sh
build_vulkan.sh
```
## GPU-SYCL
### Windows
Install Intel® oneAPI Base Toolkit manually or using the script:
```
install_oneapi.bat
```
Set up needed environment
```
"C:\Program Files (x86)\Intel\oneAPI\setvars.bat"
```
Use build script from cloned llama.cpp 
```
cd llama.cpp
.\examples\sycl\win-build-sycl.bat
```
## OpenVINO
### Windows
Prerequisites:
MSVC (script is verified with MSVC 2022). 
OpenVINO (for C++)
Run the following script in MSVC Developer PowerShell:
```
build_openvino.ps1
```
