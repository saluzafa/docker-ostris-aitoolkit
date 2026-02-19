# docker-ostris-aitoolkit

This image wraps [ostris/ai-toolkit](https://github.com/ostris/ai-toolkit) so the toolkit can be bootstrapped and launched in a container.

## How the image works

### Build time (`Dockerfile`)
The image is built from `pytorch/pytorch:latest` and prepares a base environment by:

- installing system packages (`git`, `libgl1`, `build-essential`, Python tooling, `curl`)
- installing Node.js 24.x (used by the toolkit UI)
- copying `start.sh` into the image
- exposing container port `8675`

Container startup runs:

```bash
/bin/bash /start.sh
```

### Runtime (`start.sh`)
On container start:

1. It checks whether `/workspace/ai-toolkit` exists.
2. If missing, it:
   - clones the repo from `GIT_URL` (default: `https://github.com/ostris/ai-toolkit.git`)
   - creates a Python venv in `ai-toolkit/venv`
   - installs Python requirements
   - installs pinned CUDA PyTorch wheels (`torch==2.9.1`, `torchvision==0.24.1`, `torchaudio==2.9.1`)
3. It enters `/workspace/ai-toolkit/ui` and runs:

```bash
npm run build_and_start
```

That command builds and starts the toolkit UI service.

## Build the image

```bash
./build-image.sh
```

Or directly:

```bash
docker build -t slzd/ostris-aitoolkit --platform linux/amd64 .
```

## Run the container

Basic run:

```bash
docker run --rm -it -p 8675:8675 slzd/ostris-aitoolkit
```

Use a persistent volume so clone/install happens once:

```bash
docker run --rm -it \
  -p 8675:8675 \
  -v aitoolkit-workspace:/workspace \
  slzd/ostris-aitoolkit
```

Use a fork/custom repo:

```bash
docker run --rm -it \
  -p 8675:8675 \
  -e GIT_URL=https://github.com/<you>/ai-toolkit.git \
  -v aitoolkit-workspace:/workspace \
  slzd/ostris-aitoolkit
```

## Notes

- First startup can take a while because it clones and installs dependencies.
- `/workspace` is the key persistence path.
- The service is exposed on port `8675`; map it to your host with `-p 8675:8675`.
