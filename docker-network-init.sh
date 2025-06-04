#!/bin/bash
NETWORK_NAME="rag-network"

if ! docker network ls | grep -q "$NETWORK_NAME"; then
  echo "[+] Creating Docker network: $NETWORK_NAME"
  docker network create $NETWORK_NAME
else
  echo "[i] Docker network $NETWORK_NAME already exists."
fi
