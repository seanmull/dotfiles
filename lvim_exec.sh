#!/bin/bash
docker rm -f lvim && \
  docker run --rm -d --name lvim \
  -v $(pwd):$(pwd) \
  -v lvim_share:/home/lunaruser/.local/share/lunarvim \
  -v lvim_mason:/root \
  -v lvim_config:/home/lunaruser/.config/lvim \
  -v lvim_cache:/home/lunaruser/.cache/lvim \
  -v /home/s/vimwiki:/root/vimwiki \
  -v /mnt/c/Windows/System32/clip.exe:/mnt/c/Windows/System32/clip.exe \
  -w $(pwd) lvim && docker exec -it lvim sh
