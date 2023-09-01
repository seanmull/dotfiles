FROM alpine:edge

RUN addgroup -S lunaruser

RUN adduser -S lunaruser -G lunaruser --shell /bin/sh

RUN apk add yarn git python3 py3-pip unzip wget gzip cargo neovim ripgrep alpine-sdk npm xclip neovim-doc bash --update

RUN LV_BRANCH='release-1.3/neovim-0.9' su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.3/neovim-0.9/utils/installer/install.sh)" lunaruser

RUN git config --global --add safe.directory "*"

# RUN python3 -m pip install pynvim

RUN npm i -g neovim 

# RUN mkdir -p /home/lunaruser/.local/share/fonts

# RUN cd /home/lunaruser/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFontMono-Regular.ttf

RUN ln -s /home/lunaruser/.local/bin/lvim /bin
# RUN git config --add safe.directory /home/lunaruser
# CMD [ "tail", "-f", "/dev/null" ]
ENTRYPOINT [ "/home/lunaruser/.local/bin/lvim" ]
