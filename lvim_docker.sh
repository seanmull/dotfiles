#!/bin/bash
#
if [ $# -eq 0 ]
  then
    export lvim_path=$(pwd)
  else
    export lvim_path=$(realpath $1)
fi
echo $lvim_path

docker rm -f lvim && \
docker run --rm -v $lvim_path:$lvim_path --net=host --ipc=host -e DISPLAY=$DISPLAY \
                                         -v lvim_share:/home/lunaruser/.local/share/lunarvim \
                                         -v lvim_config:/home/lunaruser/.config/lvim \
                                         --env="QT_X11_NO_MITSHM=1" \
                                         --env="_X11_NO_MITSHM=1" \
                                         -v /tmp/.X11-unix:/tmp/.X11-unix \
                                         -v lvim_mason:/root \
                                         -v lvim_cache:/home/lunaruser/.cache/lvim \
                                         -v /home/s/vimwiki:/root/vimwiki \
                                         -v /home/s/.ssh:/root/.ssh \
                                         -w $lvim_path -it lvim
