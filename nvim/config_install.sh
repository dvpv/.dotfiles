#!/bin/bash

echo "[NVIM] Installing Packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "[NVIM] Linking"
rm -rf $HOME/.config/nvim
mkdir -p $HOME/.config
ln -s $(pwd) $HOME/.config/nvim

