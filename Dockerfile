# Base OS layer
FROM ubuntu:latest


# Get the common properties to enable updating of repo list
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Added some repos to apt
RUN add-apt-repository ppa:neovim-ppa/unstable && \
    add-apt-repository ppa:deadsnakes/ppa


# Install OS dependancies
RUN apt-get update && \ 
    apt-get -y install curl \
                        fzf \
                        ripgrep \ 
                        tree \
                        git \
                        xclip \
                        python3 \
                        python3-pip \
                        nodejs \ 
                        fd-find \
                        wget \
                        make \
                        npm \
                        ninja-build \
                        gettext \ 
                        libtool \
                        cargo \
                        snapd \
                        libtool-bin \
                        autoconf \
                        automake \
                        cmake \
                        g++\
                        pkg-config\
                        zip \
                        unzip

# Set some env
# ENV http_proxy http://proxy-chain.xxx.com:911/ 790
# ENV https_proxy http://proxy-chain.xxx.com:912/ 178

# # Install pip dependancies
# RUN pip3 install pynvim 

# Install npm dependancies
# RUN npm i -g neovim prettier codespell shellcheck eslint

# Install cargo dependancies
# RUN cargo install tree-sitter-cli stylua

# Install snap dependancies
# RUN snap install go --classic

# Install neovim
RUN apt-get -y install neovim

# Install lunarvim
ENV LV_BRANCH=rolling 
RUN curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh | bash

# Inject config and customizations
## TOD0

# Create volumes
VOLUME /data

# Run lunarvim
CMD ["lvim"]
