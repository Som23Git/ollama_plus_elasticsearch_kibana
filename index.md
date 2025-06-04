---
layout: default
title: Ollama + Elasticsearch RAG Starter
---

# 🧠 Ollama + Elasticsearch RAG Starter

This repository connects [Ollama](https://ollama.com) with [Elasticsearch + Kibana](https://elastic.co) to support **OpenAI-compatible RAG (Retrieval-Augmented Generation)** experiments locally. It uses a shared Docker network to enable seamless integration between the LLM runtime and the Elastic Stack.

---

## 🚀 Quick Start

```bash
# Start Ollama with model selection (e.g., mistral or deepseek)
./start-ollama.sh

# Install and start Elasticsearch + Kibana (first time only)
curl -fsSL https://elastic.co/start-local | sh -s -- -v 8.18.2

# If already installed, start the services
cd elastic-start-local
./start.sh 

# Optional: Check network connectivity from host or containers
./network-check.sh
````

---

### ✅ Expected Output

```text
🌐 Checking connectivity to http://localhost:11434/v1/chat/completions
⏳ Sending test prompt to mistral...
✅ Ollama responded successfully!
🧠 Model response:
"A vector database is a type of database designed specifically for storing, indexing, and querying large collections of data vectors..."
```

---

## 🐳 Docker Container Setup

This setup ensures all containers (Ollama, Elasticsearch, Kibana) run in a **shared Docker network** named `rag-network`.

![Docker Container Setup](./assets/docker_container_setup.png)

Inspired by:
🔗 [Testing DeepSeek R1 locally for RAG with Ollama and Kibana – Elasticsearch Labs](https://www.elastic.co/search-labs/blog/deepseek-rag-ollama-playground)

---

## 📝 License

This project is licensed under the [MIT License](./LICENSE).

---

## 📚 Public Domain Data Attribution

This repository uses public domain content for RAG demos:

* **Title**: *Alice’s Adventures in Wonderland*
* **Blob**: [*Check here*](https://www.gutenberg.org/cache/epub/11/pg11.txt)
* **Author**: Lewis Carroll
* **Source**: [Project Gutenberg](https://www.gutenberg.org/ebooks/11)
* **License**: Public Domain (U.S.)

> As per [Project Gutenberg™ License](https://www.gutenberg.org/license), this work is freely usable in the U.S. The text file was stripped of all Gutenberg branding for compliance.

You are free to copy, modify, and use the text for any purpose.

---