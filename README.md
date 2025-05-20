# Handy Ollama Docker

This project provides a convenient way to run [Ollama](https://ollama.com/) in a Docker container with GPU support and automatic model loading.

## Features
- Automatic download and loading of the model specified in `.env`
- GPU support via NVIDIA runtime
- Healthcheck for the Ollama service
- Easy start/stop scripts

## Quick Start

1. **Copy and configure environment variables:**
   ```bash
   cp example.env .env
   # Edit .env to set your desired model and data directory
   ```
   Example `.env`:
   ```env
   LLM_MODEL_NAME=qwen3:14b
   OLLAMA_DATA_DIR=./ollama_data_dir
   ```

2. **Start Ollama:**
   ```bash
   ./start_ollama.sh
   ```
   This will start the container, download the specified model if needed, and make Ollama available at `http://localhost:11434`.

3. **Stop Ollama:**
   ```bash
   ./stop_ollama.sh
   ```

## Requirements
- Docker
- NVIDIA GPU and drivers (for GPU acceleration)

## Files
- `docker-compose.yml` — Docker Compose configuration for Ollama
- `start_ollama.sh` — Script to start the container and load the model
- `stop_ollama.sh` — Script to stop the container
- `ollama_entrypoint.sh` — Entrypoint script for the container, handles model loading
- `.env` — Environment variables (model name, data directory)
- `example.env` — Example environment file

## License
MIT 