#!/bin/bash

echo "Linking tmux"
rm -rf $HOME/.config/tmux
ln -s $(pwd) $HOME/.config/tmux

