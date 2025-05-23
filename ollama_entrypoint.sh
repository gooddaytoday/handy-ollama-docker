#!/bin/bash
echo "Running nvidia-smi inside the container:"
nvidia-smi

echo "Starting Ollama..."
/bin/ollama serve &

pid=$!
echo "Waiting for Ollama to start..."
until ollama list > /dev/null 2>&1; do
  sleep 2
done

MODEL=${LLM_MODEL_NAME}
if ollama list | grep -q "$MODEL"; then
  echo "Model $MODEL is already loaded."
else
  echo "Loading model: $MODEL"
  ollama pull "$MODEL"
  echo "Model $MODEL is ready!"
fi

wait $pid
