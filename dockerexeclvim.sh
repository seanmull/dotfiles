# docker run -w /tmp -it --rm alpine:edge sh -uelic 'addgroup -S lunaruser && adduser -S lunaruser -G lunaruser --shell /bin/sh && apk add yarn git python3 cargo neovim ripgrep alpine-sdk bash --update && LV_BRANCH='release-1.3/neovim-0.9' su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.3/neovim-0.9/utils/installer/install.sh)" lunaruser && su -c /home/lunaruser/.local/bin/lvim lunaruser'
# docker rm -f lvim && docker run -d --name 'lvim' lvim && docker exec -it -t lvim /home/lunaruser/.local/bin/lvim
# docker run --rm -v $(pwd):$(pwd) -w $(pwd) --mount 'type=bind,source=/mnt/lunarvim/.local/share/lunarvim,destination=/home/lunaruser/.local/share/lunarvim' -i -t lvim .
# create the volumes
docker run --rm -v $(pwd):$(pwd) -v lvim_share:/home/lunaruser/.local/share/lunarvim -v lvim_config:/home/lunaruser/.config/lvim -v lvim_cache:/home/lunaruser/.cache/lvim -w $(pwd) -i -t lvim
# docker run --rm -d --name lvim -v $(pwd):$(pwd) -v lvim_share:/home/lunaruser/.local/share/lunarvim -v lvim_config:/home/lunaruser/.config/lvim -v lvim_cache:/home/lunaruser/.cache/lvim -w $(pwd) lvim && docker exec -it lvim sh
