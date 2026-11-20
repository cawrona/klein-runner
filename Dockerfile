# klein-runner: FLUX.2 klein 4B runtime for RunPod (deps baked, weights fetched at boot).
# Same base as the old path, so hosts that already cached it only pull the small deps layer.
FROM pytorch/pytorch:2.8.0-cuda12.6-cudnn9-runtime

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    HF_XET_HIGH_PERFORMANCE=1 \
    KLEIN_PREBAKED=1 \
    KLEIN_MODEL=black-forest-labs/FLUX.2-klein-4B

# Torch comes from the base image; pip must not replace it.
RUN pip install diffusers transformers accelerate sentencepiece protobuf hf_xet brotli zstandard "huggingface_hub>=0.30" \
 && python -c "import torch, diffusers, transformers; print(torch.__version__, diffusers.__version__, transformers.__version__)" \
 && pip freeze > /opt/requirements.lock

COPY prefetch.py /opt/prefetch.py

LABEL org.opencontainers.image.description="FLUX.2 klein 4B runtime (diffusers, no weights)" \
      org.opencontainers.image.licenses="Apache-2.0"
