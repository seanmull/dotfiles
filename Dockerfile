FROM alpine:edge

RUN addgroup -S lunaruser

RUN adduser -S lunaruser -G lunaruser --shell /bin/sh

RUN apk add yarn git python3 cargo neovim ripgrep alpine-sdk bash --update

RUN LV_BRANCH='release-1.3/neovim-0.9' su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.3/neovim-0.9/utils/installer/install.sh)" lunaruser

# ENTRYPOINT [ "/home/lunaruser/.local/bin/lvim" ]
CMD [ "tail", "-f", "/dev/null" ]
