#!/bin/bash

echo "Linking nvim"
rm -rf $HOME/.config/nvim
ln -s $(pwd) $HOME/.config/nvim

