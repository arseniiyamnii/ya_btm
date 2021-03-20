#!/bin/bash
if [ $1 = "init" ]; then
    mkdir -p ~/.yabtm/templates
    touch ~/.yabtm/dump.json
    echo "instalaition complate"
fi
if [ $1 = "install" ]; then
    echo $2
    dirname=$(echo "$2" | awk -F/ '{print($2)}' | awk -F. '{print($1)}')
    echo $dirname
    mkdir -p ~/.yabtm/templates/$dirname
    git clone $2 ~/.yabtm/templates/$dirname
    echo "download complate"
fi
if [ $1 = "uninstall" ]; then
    rm -rf ~/.yabtm
    echo "uninstall complate"
fi
if [ $1 = "show-temps" ]; then
    ls ~/.yabtm/templates
fi
if [ $1 = "use" ]; then
    cp -r ~/.yabtm/templates/"$2"/* .
    ya_btm_render
    cp -r ./template/* .
fi
if [ $1 = "update" ]; then
bash -c "cd ~/.yabtm/templates/$2; git pull --force"
fi
if [ $1 = "update-all" ]; then
for i in ~/.yabtm/templates/*; do
     echo $i
     bash -c "cd $i; git pull"
done
fi
if [ $1 = "help" ]; then
cat << EOF
usage: ya_brm.sh [command][options]
commands:
help - this help
update <template> = git pull template
install <github repo.git> = download repo
use <template name>
show-temps = show all templates names
update-all = update all templates(git pull)
uninstall = rm ~/.yabtm folder
init = create ~/.yabtm folder
EOF
fi

