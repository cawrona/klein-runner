# klein-runner image

Container for a RunPod image job: the pytorch 2.8 / CUDA 12.6 base plus
diffusers, transformers and friends, so the pod skips the pip step. The FLUX.2 klein 4B
weights (Apache 2.0, ~16 GB) are not baked in; `prefetch.py` starts downloading them the
moment the pod boots, in parallel with the input upload.

Nothing secret lives here: no keys, no tokens.

## Build
This folder is the root of a GitHub repo (`klein-runner`). Pushing to `main` or running the
workflow by hand builds and pushes `ghcr.io/<owner>/klein-runner:latest` with the built-in
`GITHUB_TOKEN`. Make the package public once (GitHub → Packages → klein-runner → settings) so
RunPod can pull it without registry credentials.

## Use
    python3 klein_runpod.py jobs.tsv out/ --image            # default ghcr image
    python3 klein_runpod.py jobs.tsv out/ --image <ref>      # any other tag
Without `--image` the tool keeps the old path (stock image + pip install at start).
