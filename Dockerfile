FROM alpine:edge

RUN addgroup -S lunaruser

RUN adduser -S lunaruser -G lunaruser --shell /bin/sh

RUN apk add yarn git python3 py3-pip unzip wget gzip cargo neovim ripgrep alpine-sdk npm xclip neovim-doc bash --update

RUN LV_BRANCH='release-1.3/neovim-0.9' su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.3/neovim-0.9/utils/installer/install.sh)" lunaruser

RUN git config --global --add safe.directory "*"

RUN npm i -g neovim 

COPY --from=golang:1.21-alpine /usr/local/go/ /usr/local/go/

ENV PATH="/usr/local/go/bin:${PATH}"

ENV PATH="/root/go/bin:${PATH}"

RUN go install github.com/jesseduffield/lazygit@latest

RUN git config --global user.name "sean mull"

RUN git config --global user.email "kimlan065@gmail.com"

RUN ln -s /home/lunaruser/.local/bin/lvim /bin

ENTRYPOINT [ "/home/lunaruser/.local/bin/lvim" ]
