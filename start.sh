#!/bin/bash

set -e

INSTALL_DIR="/workspace/ai-toolkit"
GIT_URL=${GIT_URL:-https://github.com/ostris/ai-toolkit.git}

if [ ! -d "$INSTALL_DIR" ]; then
  echo "AI-Toolkit not found. Cloning and installing..."
  cd /workspace
  git clone $GIT_URL
  cd ai-toolkit
  python3 -m venv venv
  source venv/bin/activate
  pip3 install -r requirements.txt
  pip3 install --no-cache-dir torch==2.9.1 torchvision==0.24.1 torchaudio==2.9.1 --index-url https://download.pytorch.org/whl/cu130
  pip install -r requirements.txt
else
  echo "AI-Toolkit already exists. Skipping clone and install."
fi

cd /workspace/ai-toolkit/ui
npm run build_and_start
