#!/bin/bash
set -e

# Print Docker Info
echo "🔍 Docker Host Info:"
OS=$(docker info --format '{{.OperatingSystem}}')
CPUS=$(docker info --format '{{.NCPU}}')
MEM_BYTES=$(docker info --format '{{.MemTotal}}')
MEM_GIB=$(awk "BEGIN {printf \"%.2f\", $MEM_BYTES/1024/1024/1024}")

echo "  OS:     $OS"
echo "  CPUs:   $CPUS"
echo "  Memory: $MEM_BYTES bytes (~$MEM_GIB GiB)"


echo ""
echo "📦 Available models:"
echo "1. mistral       - 🪶 Lightweight (~4 GiB RAM), fast, accurate, well-balanced."
echo "2. deepseek-r1   - 🧠 Large model (~5.5 GiB RAM), chain-of-thought reasoning, better for complex RAG."

# Ask for user input
read -p "👉 Choose a model to pull [1=mistral, 2=deepseek-r1] (default: 1): " MODEL_CHOICE

# Decide model name
if [[ "$MODEL_CHOICE" == "2" ]]; then
  MODEL="deepseek-r1:7b"
else
  MODEL="mistral"
fi

echo ""
echo "✅ Selected model: $MODEL"

# Variables
NETWORK="rag-network"
OLLAMA_DATA_DIR="./ollama"

# Ensure network exists
./docker-network-init.sh

# Run Ollama container
echo "�� Starting Ollama container..."
docker run -d \
  --name ollama \
  --network $NETWORK \
  -v $(pwd)/$OLLAMA_DATA_DIR:/root/.ollama \
  -p 11434:11434 \
  ollama/ollama

# Pull the selected model
echo "⬇️ Pulling model: $MODEL ..."
docker exec -it ollama ollama pull $MODEL

echo "🎉 $MODEL is successfully installed and running inside the Ollama container!"
echo "You can now access the Ollama API at http://localhost:11434"
echo "To stop the Ollama container, run: docker stop ollama"