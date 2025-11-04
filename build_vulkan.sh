#!/usr/bin/env bash
set -euo pipefail

LLAMA_DIR=llama.cpp
VULKAN_VERSION=1.4.328.1
VULKAN_DIR=vulkan-sdk

if [ ! -d "$LLAMA_DIR" ]; then
  echo "$LLAMA_DIR not found. Cloning llama.cpp"
  git clone "https://github.com/ravi9/llama.cpp.git"
  echo "LLama.cpp is cloned"
fi


if [ ! -d "$VULKAN_DIR" ]; then
  echo "Downloading Vulkan SDK"
  wget "https://sdk.lunarg.com/sdk/download/$VULKAN_VERSION/linux/vulkan-sdk.tar.xz"
  echo "Extracting Vulkan SDK"
  mkdir $VULKAN_DIR
  tar xf vulkan-sdk.tar.xz -C "$VULKAN_DIR"
fi

echo "Setting up Vulkan SDK environment"
source $VULKAN_DIR/$VULKAN_VERSION/setup-env.sh

cd "$LLAMA_DIR"
echo "Switching to the dev_backend_openvino branch"
git switch dev_backend_openvino
echo "Configuring CMake with GGML_USE_VULKAN=1 ..."
cmake -B build_vulkan -DGGML_VULKAN=1
echo "Building..."
cmake --build build_vulkan --config Release -j $(nproc)

echo "Vulkan build is finished"