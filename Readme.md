# Ollama + Elasticsearch RAG Starter

This repo connects [Ollama](https://ollama.com) with [Elasticsearch + Kibana](https://elastic.co) to support OpenAI-compatible RAG experiments locally.

## 🚀 How to Run

```bash
# Start Ollama
./start-ollama.sh

# Start Elasticsearch & Kibana

curl -fsSL https://elastic.co/start-local | sh -s -- -v 8.18.2

# If already created,

cd elastic-start-local
./start.sh 

# Check network(Optional)

./network_check.sh

# Expected Output:

🌐 Checking connectivity to http://localhost:11434/v1/chat/completions
⏳ Sending test prompt to mistral...
✅ Ollama responded successfully!
🧠 Model response:
" A vector database is a type of database designed specifically for storing, indexing, and querying large collections of data vectors, which are mathematical entities with both magnitude and direction. In simpler terms, they can be seen as an array or list of numbers. Vector databases gained prominence in the field of machine learning, artificial intelligence, and data analysis due to their ability to efficiently process high-dimensional vector data (large number of dimensions), often used for tasks like image recognition, recommend systems, or natural language processing.\n\n   Different from traditional relational databases that primarily focus on structuring data with a well-defined schema, these NoSQL databases offer more flexible storage options, allowing them to incorporate complex data types and handle unstructured or semi-structured data without the need for extensive preprocessing. Some popular examples of vector database systems are Faiss, Milvus, Pinecone, and Elasticsearch (with its VectorSphere extension).\n\n   One common operation within a vector database is performing similarity search, as vectors can be compared to each other using various distance measures like Euclidean distance or Cosine similarity. These databases employ sophisticated indexing techniques like hash tables, k-d trees, and Annoy (Approximate Nearest Neighbors Optimized Yahoo) to quickly fetch the closest vectors in a large dataset given a new query vector, enabling rapid processing of vector data at scale.\n\n   Vector databases prove beneficial for real-world applications like image search engines (e.g., Google Images), personalized recommendations (e.g., Amazon product suggestions or Netflix movie recommendations), and natural language processing tools (e.g., speech recognition). As a result, they have become crucial components in today's data-driven and AI-powered solutions."

```

## Docker Container Setup

![Docker Container Setup](./assets/docker_container_setup.png)

Inspired from here: https://www.elastic.co/search-labs/blog/deepseek-rag-ollama-playground.

