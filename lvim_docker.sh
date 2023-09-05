#!/bin/bash
# convert from relative path to absolute
lvim_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd $lvim_path

docker rm -f lvim && \
docker run --rm -v $lvim_path:$lvim_path -v lvim_share:/home/lunaruser/.local/share/lunarvim \
                                         -v lvim_config:/home/lunaruser/.config/lvim \
                                         -v lvim_mason:/root \
                                         -v lvim_cache:/home/lunaruser/.cache/lvim \
                                         -v /home/s/vimwiki:/root/vimwiki \
                                         -v /mnt/c/Windows/System32/clip.exe:/mnt/c/Windows/System32/clip.exe \
                                         -w $lvim_path -it lvim
