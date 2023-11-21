#!/bin/bash
#
if [ $# -eq 0 ]
  then
    export lvim_path=$(pwd)
  else
    export lvim_path=$(realpath $1)
fi
echo $lvim_path
export home_path=$(realpath $HOME)

docker rm -f lvim && \
docker run --rm -v $home_path:$home_path --net=host --ipc=host -e DISPLAY=$DISPLAY \
                                         -v lvim_share:/home/lunaruser/.local/share/lunarvim \
                                         -v lvim_config:/home/lunaruser/.config/lvim \
                                         --env="QT_X11_NO_MITSHM=1" \
                                         --env="_X11_NO_MITSHM=1" \
                                         -v /tmp/.X11-unix:/tmp/.X11-unix \
                                         -v lvim_mason:/root \
                                         -v lvim_cache:/home/lunaruser/.cache/lvim \
                                         -v /home/seanm@NIGHTLIFE.COM.AU/vimwiki:/root/vimwiki \
                                         -v /home/seanm@NIGHTLIFE.COM.AU/.ssh:/root/.ssh \
                                         -v nvm:/root/.nvm \
                                         -w $lvim_path -it lvim
