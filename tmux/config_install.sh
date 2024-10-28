#!/bin/bash

echo "[TMUX] Downloading TPM"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "[TMUX] Linking"
rm -rf $HOME/.config/tmux
mkdir -p $HOME/.config
ln -s $(pwd) $HOME/.config/tmux

