#!/bin/bash

for install in $(find -name "config_install.sh")
do
    cd $(dirname $install)
    sh ./config_install.sh
    cd ..
done

