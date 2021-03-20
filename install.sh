#!/bin/bash
if [ "$1" = "uninstall" ]; then
    rm -rf /usr/local/bin/ya_btm /usr/local/bin/ya_btm_render ~/.yabtm
else
    ln -s $(pwd)/ya_btm.sh /usr/local/bin/ya_btm
    ln -s $(pwd)/render.py /usr/local/bin/ya_btm_render
    ya_btm init
fi
