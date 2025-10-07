# llama.cpp_build
Here you can find scripts and onstructions how to build llama.cpp with diferent backends: CPU, VULKAN, SYCL, OpenVINO.

Usage instructions:
```
git clone https://github.com/avbelova/llama.cpp_build.git
cd llama.cpp_build
```
Clone llama.cpp
```
clone_llama_cpp.bat
Run the build process depending on the needed backend:
```
## CPU
```
build_cpu.bat
```
## GPU-VULKAN
Install VULKAN SDK. The following script downloads VULKAN SDK installer and runs it. Please follow the installer steps manually.
```
install_vulkan.bat
```
Build
```
build_vulkan.bat
```
## GPU-SYCL
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
llama.cpp\examples\sycl\win-build-sycl.bat
```
