#!/bin/bash
set -e

echo "🔹 Starting deployment..."

# Docker Hub login (only if credentials exist)
if [[ -n "$DOCKERHUB_USERNAME" && -n "$DOCKERHUB_PASSWORD" ]]; then
  echo "🛠️ Logging into Docker Hub..."
  echo "$DOCKERHUB_PASSWORD" | docker login --username "$DOCKERHUB_USERNAME" --password-stdin || {
    echo "❌ Docker Hub login failed"; exit 1
  }
fi

echo "🚀 Bringing up containers..."
docker compose -f docker-compose.yaml up -d --pull always || {
  echo "❌ Docker compose failed"; exit 1
}

echo "✅ Deployment complete!"
