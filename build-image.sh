#!/bin/bash

set -e

# Ensure a version argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  echo "Example: $0 1.0"
  exit 1
fi

VERSION="$1"
IMAGE="slzd/ostris-aitoolkit"

docker build . \
  -t ${IMAGE}:latest \
  -t ${IMAGE}:${VERSION} \
  --platform linux/amd64

docker push ${IMAGE}:latest
docker push ${IMAGE}:${VERSION}

# Remove local images
docker rmi ${IMAGE}:latest
docker rmi ${IMAGE}:${VERSION}
