#!/bin/bash
docker rm -f lvim && \
  docker run --rm -d --name lvim \
  -v $(pwd):$(pwd) \
  --net=host --ipc=host -e DISPLAY=:0 \
  --env="QT_X11_NO_MITSHM=1" \
  --env="_X11_NO_MITSHM=1" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v lvim_share:/home/lunaruser/.local/share/lunarvim \
  -v $XAUTHORITY:/tmp/.XAuthority -e XAUTHORITY=/tmp/.XAuthority \
  -v lvim_mason:/root \
  -v lvim_config:/home/lunaruser/.config/lvim \
  -v lvim_cache:/home/lunaruser/.cache/lvim \
  -v /home/s/vimwiki:/root/vimwiki \
  -v /home/s/.ssh:/root/.ssh \
  -w $(pwd) lvim && docker exec -it lvim sh
