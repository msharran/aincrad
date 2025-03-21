#!/bin/bash

# NOTE: Don't install programming languages,
# install them on demand. Only install dependencies

set -e

echo "*Installing dependencies"
sudo apt-get -y update
sudo apt-get install -y \
    wget git bat fzf zoxide eza ripgrep make curl stow fish btop \
    libssl-dev:arm64 \
    git-crypt

cd $HOME/opt \
    && sudo apt-get -y update \
    && sudo apt-get -y install ninja-build gettext cmake unzip curl build-essential \
    && git clone https://github.com/neovim/neovim \
    && cd neovim \
    && make CMAKE_BUILD_TYPE=Release \
    && ln -s $HOME/opt/neovim/build/bin/nvim $HOME/.local/bin/nvim \
    && nvim --version


echo "*Installing starship"
mkdir -p $HOME/.local/bin
curl -sS https://starship.rs/install.sh | BIN_DIR=$HOME/.local/bin sh

echo "*Setting fish as default shell"
sudo chsh -s /usr/bin/fish msharran

echo "*Setting up projects dir"
mkdir -p $HOME/projects/{work,play}

echo "*Setting up aincrad"
if [ ! -d "$HOME/aincrad" ]; then
    git clone https://github.com/msharran/aincrad
fi
pushd aincrad
make
popd
