#!/bin/bash

for install in $(find -name "config_install.sh")
do
    cd $(dirname $install)
    sh ./config_install.sh
    cd ..
done

# Install PS1
cat ps1.sh >> ~/.bashrc

