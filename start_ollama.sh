#!/bin/bash
set -e

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