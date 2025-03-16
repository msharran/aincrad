#!/bin/bash

# NOTE: Don't install programming languages,
# install them on demand. Only install dependencies

set -e

echo "*Installing dependencies"
sudo apt-get -y update
sudo apt-get install -y \
    wget git bat fzf zoxide eza ripgrep neovim make curl stow fish btop \
    libssl-dev:arm64 \
    git-crypt

echo "*Installing starship"
curl -sS https://starship.rs/install.sh | sh

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
