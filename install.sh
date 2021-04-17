#!/bin/bash
if [ "$1" = "uninstall" ]; then
	sudo rm /usr/local/bin/ya_btm
	sudo rm /usr/local/bin/ya_btm_render
	sudo rm /usr/local/bin/ya_btm_hook
	sudo rm -rf ~/.yabtm
else
	if ! [ -x "$(command -v pip3)" ]; then
		sudo apt install python3-pip
	fi
	if  [ -x "$(command -v pip3)" ]; then
		if ! python -c "import pystache" &> /dev/null; then
			    sudo pip3 install pystache
		fi
	fi
	ln -s $(pwd)/ya_btm.sh /usr/local/bin/ya_btm
	ln -s $(pwd)/render.py /usr/local/bin/ya_btm_render
	ln -s $(pwd)/ya_btm_hooks.sh /usr/local/bin/ya_btm_hook
	mkdir -p ~/.yabtm/templates
fi
