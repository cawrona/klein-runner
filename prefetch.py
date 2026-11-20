"""Download the klein weights into the HF cache as soon as the container boots.

Started in the background by the pod command, so the 16 GB download overlaps with
the input upload; gen.py's from_pretrained then finds (or waits on) the same files.
"""
import os, time
from huggingface_hub import snapshot_download

t = time.time()
snapshot_download(os.environ.get('KLEIN_MODEL', 'black-forest-labs/FLUX.2-klein-4B'))
print('prefetch done', round(time.time() - t), 's', flush=True)
