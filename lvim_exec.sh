#!/bin/bash
docker rm -f lvim && \
  docker run --rm -d --name lvim \
  -v $(pwd):$(pwd) \
  --net=host --ipc=host -e DISPLAY=$DISPLAY \
  --env="QT_X11_NO_MITSHM=1" \
  --env="_X11_NO_MITSHM=1" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v lvim_share:/home/lunaruser/.local/share/lunarvim \
  -v lvim_mason:/root \
  -v lvim_config:/home/lunaruser/.config/lvim \
  -v lvim_cache:/home/lunaruser/.cache/lvim \
  -v /home/seanm@NIGHTLIFE.COM.AU/vimwiki:/root/vimwiki \
  -v /home/seanm@NIGHTLIFE.COM.AU/.ssh:/root/.ssh \
  -v /usr/local/lib:/usr/local/lib \
  -w $(pwd) lvim && docker exec -it lvim sh
