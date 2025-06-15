#!/bin/bash
set -e

# Step 1: Prompt for Elasticsearch credentials
read -p "Enter your Elasticsearch username: " ES_USER
read -s -p "Enter your Elasticsearch password: " ES_PASS
echo ""

AUTH_HEADER=$(echo -n "$ES_USER:$ES_PASS" | base64)

# Step 0.1: Check available inference endpoints
echo ""
echo "🔍 Checking available inference models..."
curl --location --request GET "http://localhost:9200/_inference" \
  --header "Authorization: Basic $AUTH_HEADER" \
  --header "Content-Type: application/json"

# Step 0.2: Trigger loading of the e5 model
echo ""
echo "⚙️  Triggering warm-up of inference model .multilingual-e5-small-elasticsearch..."
curl --location --request POST "http://localhost:9200/_inference/text_embedding/.multilingual-e5-small-elasticsearch" \
  --header "Authorization: Basic $AUTH_HEADER" \
  --header "Content-Type: application/json" \
  --data '{
    "input": "are internet memes about deepseek sound investment advice?"
  }'
echo ""
echo "✅ Inference model initialized successfully!"
echo "--------------------------------------------"
echo "📌 Model: .multilingual-e5-small-elasticsearch"
echo "📌 Status: Embedding warm-up completed"
echo ""

# Step 2: Create the ingest pipeline
echo "🔧 Creating ingest pipeline 'alice-pipeline'..."
curl --location --request PUT "http://localhost:9200/_ingest/pipeline/alice-pipeline" \
  --header "Content-Type: application/json" \
  --header "Authorization: Basic $AUTH_HEADER" \
  --data '{
    "description": "Ingest pipeline created by file data visualizer",
    "processors": [
      {
        "attachment": {
          "field": "data",
          "remove_binary": true,
          "indexed_chars": -1
        }
      },
      {
        "set": {
          "field": "content",
          "copy_from": "attachment.content"
        }
      }
    ]
  }'
echo ""
echo "✅ Ingest pipeline created: alice-pipeline"
echo "--------------------------------------------"
echo "📦 Description: Attachment extraction + content enrichment"
echo ""

# Step 3: Create index with mapping
echo "📘 Creating index 'book_alice' with semantic mapping..."
curl --location --request PUT 'http://localhost:9200/book_alice' \
  --header 'Content-Type: application/json' \
  --header "Authorization: Basic $AUTH_HEADER" \
  --data '{
    "mappings": {
      "properties": {
        "attachment": {
          "properties": {
            "content":        { "type": "text" },
            "content_length": { "type": "long" },
            "content_type":   { "type": "text" },
            "format":         { "type": "text" },
            "language":       { "type": "text" }
          }
        },
        "content": {
          "type": "semantic_text",
          "inference_id": ".multilingual-e5-small-elasticsearch"
        }
      }
    }
  }'
echo ""
echo "✅ Index created: book_alice"
echo "--------------------------------------------"
echo "📄 Mappings include: semantic_text + attachment fields"
echo ""

# Step 4: Ingest payload.json into the index
PAYLOAD_PATH="./elastic-start-local/assets/payload.json"

if [ ! -f "$PAYLOAD_PATH" ]; then
  echo "❌ File $PAYLOAD_PATH not found."
  exit 1
fi

echo "📥 Ingesting payload.json into 'book_alice' index using pipeline..."
curl --location 'http://localhost:9200/book_alice/_doc?pipeline=alice-pipeline' \
  --header 'Content-Type: application/json' \
  --header "Authorization: Basic $AUTH_HEADER" \
  --data-binary @$PAYLOAD_PATH

echo ""
echo "✅ Document ingested to Elasticsearch!"
echo "--------------------------------------------"
echo "📂 Index: book_alice"
echo "📌 Pipeline: alice-pipeline"
echo "🧠 Content: Embedded with multilingual-e5-small-elasticsearch"
echo ""
