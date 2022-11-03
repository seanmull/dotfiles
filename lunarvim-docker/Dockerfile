FROM ubuntu:latest
RUN DEBIAN_FRONTEND=noninteractive apt update && DEBIAN_FRONTEND=noninteractive apt-get install -y git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip xdg-utils curl doxygen python3 python3-pip curl
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash
RUN apt-get install -y nodejs
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /var/tmp/rust-install.sh && sh /var/tmp/rust-install.sh -y 
RUN echo "source $HOME/.cargo/env" >> /root/.bashrc
RUN ln -s /root/.cargo/bin/cargo /usr/local/bin/cargo
RUN cargo install ripgrep 
RUN cargo install fd-find
RUN python3 -m pip install pynvim
RUN npm i -g neovim 
RUN npm i -g tree-sitter-cli --allow-root --unsafe-perm=true
RUN cd /var/tmp && git clone https://github.com/neovim/neovim && cd neovim && git checkout nightly && make install
# Need this stuff if want to run nightly
RUN mkdir /installer
COPY ./install.sh /installer/install.sh
RUN chmod u+x /installer/install.sh 
ENV PATH "$PATH:/root/.local/share/lvim"
RUN mkdir /usr/share/desktop-directories/
RUN ./installer/install.sh
# RUN curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | bash
RUN ln -s /root/.local/bin/lvim /usr/local/bin/lvim
ENV PATH "$PATH:/root/.cargo/bin"
RUN npm i -g prettier codespell shellcheck eslint --allow-root --unsafe-perm=true
RUN cargo install stylua
RUN python3 -m pip install flake8 isort black
ENV PATH "$PATH:/usr/bin"
RUN apt-get install -y apt-utils xclip golang-go
RUN go install mvdan.cc/sh/v3/cmd/shfmt@latest
RUN curl -sS https://webi.sh/shfmt | sh
RUN bash ~/.config/envman/PATH.env
RUN go env -w GO111MODULE=off
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_0.35_Linux_x86_64.tar.gz"
RUN file lazygit.tar.gz
RUN tar xf lazygit.tar.gz -C /usr/local/bin lazygit
RUN mkdir -p /root/dev/microsoft
RUN git clone https://github.com/microsoft/vscode-node-debug2.git /root/dev/microsoft/vscode-node-debug2
WORKDIR /root/dev/microsoft/vscode-node-debug2
RUN npm install 
RUN npm run build
RUN git config --global --add safe.directory "*"
WORKDIR /usr/src/lvim
ENTRYPOINT "lvim"
