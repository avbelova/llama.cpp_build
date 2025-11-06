#!/usr/bin/env bash
set -euo pipefail

LLAMA_DIR=llama.cpp
OPENVINO_DIR=/opt/intel/openvino/

sudo apt-get update
sudo apt-get install -y build-essential libcurl4-openssl-dev libtbb12 cmake ninja-build python3-pip curl wget tar

if [ ! -d "$LLAMA_DIR" ]; then
  echo "$LLAMA_DIR not found. Cloning llama.cpp"
  git clone "https://github.com/ravi9/llama.cpp.git"
  echo "LLama.cpp is cloned"
fi

if [ ! -d "$OPENVINO_DIR" ]; then
  echo "Installing OpenVINO"
  wget https://raw.githubusercontent.com/ravi9/misc-scripts/main/openvino/ov-archive-install/install-openvino-from-archive.sh
  chmod +x install-openvino-from-archive.sh
  ./install-openvino-from-archive.sh
fi

bash "/opt/intel/openvino/setupvars.sh"

cd "$LLAMA_DIR"
echo "Switching to the dev_backend_openvino branch"
git switch dev_backend_openvino

echo "Configuring CMake"
cmake -B build/ReleaseOV -G Ninja -DCMAKE_BUILD_TYPE=Release -DGGML_OPENVINO=ON -DGGML_CPU_REPACK=OFF
echo "Building..."
cmake --build build/ReleaseOV --config Release -j $(nproc)

echo "OpenVINO build is finished"