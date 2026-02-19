# docker-ostris-aitoolkit

Docker image wrapper for [ostris/ai-toolkit](https://github.com/ostris/ai-toolkit) with persistent workspace support.

## Required usage

You must mount a host volume to `/workspace`.

Why: the container installs AI-Toolkit into `/workspace/ai-toolkit` on first start. Without a mounted volume, that install is lost when the container is removed.

## Quick start

```bash
docker run --rm -it \
  -p 8675:8675 \
  -v "$(pwd)/workspace:/workspace" \
  slzd/ostris-aitoolkit
```

Then open AI-Toolkit on `http://localhost:8675`.

## Optional environment variables

- `HF_HOME` (default: `/workspace/huggingface`)
  - Hugging Face cache/model directory.
- `HF_TOKEN` (default: empty)
  - Optional token for accessing private Hugging Face resources.
- `AI_TOOLKIT_AUTH` (default: empty)
  - Optional auth setting to protect AI-Toolkit access.

Example with optional variables:

```bash
docker run --rm -it \
  -p 8675:8675 \
  -v "$(pwd)/workspace:/workspace" \
  -e HF_HOME=/workspace/huggingface \
  -e HF_TOKEN=your_hf_token \
  -e AI_TOOLKIT_AUTH=your_auth_value \
  slzd/ostris-aitoolkit
```

## Notes

- First container start may take a while because AI-Toolkit is cloned and dependencies are installed.
- Later starts are faster as long as the same `/workspace` volume is reused.
