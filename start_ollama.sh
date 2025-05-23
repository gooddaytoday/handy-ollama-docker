#!/bin/bash
set -e

# Function to check and fix NVIDIA UVM if needed
check_and_fix_nvidia_uvm() {
    echo "Checking NVIDIA UVM status..."

    # Test if nvidia_uvm is working properly by checking if it's loaded and accessible
    if ! lsmod | grep -q nvidia_uvm; then
        echo "nvidia_uvm module not loaded, loading it..."
        sudo modprobe nvidia_uvm
    else
        # Test CUDA initialization in a simple way
        # If this fails, we need to reload the module
        if ! timeout 5 nvidia-smi > /dev/null 2>&1; then
            echo "NVIDIA drivers seem unresponsive, reloading nvidia_uvm..."
            sudo rmmod nvidia_uvm || echo "Failed to unload nvidia_uvm (may not be critical)"
            sudo modprobe nvidia_uvm
        fi
    fi

    echo "NVIDIA UVM check completed."
}

# Check and fix NVIDIA UVM before starting
check_and_fix_nvidia_uvm

# Reading variable from .env
if [ -f .env ]; then
  OLLAMA_DATA_DIR=$(grep '^OLLAMA_DATA_DIR=' .env | cut -d '=' -f2-)
else
  echo ".env file not found!" >&2
  exit 1
fi

echo "OLLAMA_DATA_DIR: $OLLAMA_DATA_DIR"

echo "Starting Ollama container..."
OLLAMA_DATA_DIR="$OLLAMA_DATA_DIR" docker compose up -d

echo "Logs:"
docker logs ollama
