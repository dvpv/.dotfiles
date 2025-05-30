#!/bin/bash

echo "[NVIM] Linking"
rm -rf $HOME/.config/nvim
mkdir -p $HOME/.config
ln -s $(pwd) $HOME/.config/nvim

