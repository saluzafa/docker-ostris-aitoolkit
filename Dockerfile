FROM pytorch/pytorch:latest
ENV HF_HOME=/workspace/huggingface
WORKDIR /workspace
RUN <<-EOF
apt-get update -y
apt-get install -y git libgl1 build-essential python-is-python3 python3-dev curl
EOF
RUN <<-EOF
DEBIAN_FRONTEND=noninteractive curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
EOF
COPY start.sh /start.sh
EXPOSE 8675
CMD ["/bin/bash", "/start.sh"]
