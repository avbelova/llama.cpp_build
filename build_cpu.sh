#!/usr/bin/env bash
set -euo pipefail

LLAMA_DIR=llama.cpp

if [ ! -d "$LLAMA_DIR" ]; then
  echo "$LLAMA_DIR not found. Cloning llama.cpp"
  git clone "https://github.com/ravi9/llama.cpp.git"
  echo "LLama.cpp is cloned"
fi

cd "$LLAMA_DIR"
echo "Switching to the dev_backend_openvino branch"
git switch dev_backend_openvino

echo "Configuring CMake"
cmake -B build_cpu
echo "Building..."
cmake --build build_cpu --config Release -j $(nproc)

echo "CPU build is finished"