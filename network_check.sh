#!/bin/bash
set -e

# Config
MODEL="mistral"
PROMPT="Explain what a vector database is."
HOST=${1:-localhost}
PORT=11434
URL="http://$HOST:$PORT/v1/chat/completions"

# Function to run test
function test_ollama() {
  echo "🌐 Checking connectivity to $URL"
  echo "⏳ Sending test prompt to $MODEL..."

  RESPONSE=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -H "Content-Type: application/json" -X POST $URL -d "{
    \"model\": \"$MODEL\",
    \"messages\": [
      { \"role\": \"user\", \"content\": \"$PROMPT\" }
    ]
  }")

  # Extract HTTP status code
  HTTP_STATUS=$(echo "$RESPONSE" | grep HTTP_STATUS | sed 's/HTTP_STATUS://')
  BODY=$(echo "$RESPONSE" | sed '/HTTP_STATUS:/d')

  if [ "$HTTP_STATUS" == "200" ]; then
    echo "✅ Ollama responded successfully!"
    echo "🧠 Model response:"
    echo "$BODY" | jq '.choices[0].message.content'
  else
    echo "❌ Failed to reach Ollama (HTTP $HTTP_STATUS)"
    echo "Response:"
    echo "$BODY"
  fi
}

# Run test
test_ollama

