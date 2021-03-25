#!/bin/bash
#if [ "$1" = "init" ]; then
#    mkdir -p ~/.yabtm/templates
#    touch ~/.yabtm/dump.json
#    echo "instalaition complate"
#fi
if [ "$1" = "install" ]; then
	echo $2
	dirname=$(echo "$2" | awk -F/ '{print($2)}' | awk -F. '{print("$1")}')
	echo $dirname
	mkdir -p ~/.yabtm/templates/$dirname
	git clone $2 ~/.yabtm/templates/$dirname
	echo "download complate"
fi
if [ "$1" = "uninstall" ]; then
	rm -rf ~/.yabtm
	echo "uninstall complate"
fi
if [ "$1" = "show-temps" ]; then
	ls ~/.yabtm/templates
fi
if [ "$1" = "use" ]; then
	mkdir yabtm_temp
	cp -r ~/.yabtm/templates/"$2"/. ./yabtm_temp
	cd yabtm_temp
	ya_btm_render
	cd ..
	cp -r ./yabtm_temp/template/. .
	rm -rf yabtm_temp
fi
if [ "$1" = "update" ]; then
	bash -c "cd ~/.yabtm/templates/$2; git pull --force"
fi
if [ "$1" = "update-all" ]; then
	for i in ~/.yabtm/templates/*; do
		echo $i
		bash -c "cd $i; git pull"
	done
fi
if [ "$1" = "help" ]; then
	cat <<EOF
usage: ya_brm.sh [command][options]
commands:
help - this help
chooser
update <template> = git pull template
install <github repo.git> = download repo
use <template name>
show-temps = show all templates names
update-all = update all templates(git pull)
uninstall = rm ~/.yabtm folder
init = create ~/.yabtm folder
EOF
fi
if [ "$1" = "chooser" ]; then
	echo "choose your template: "
	num=1
	#вывод списка шаблонов
	for i in ~/.yabtm/templates/*; do
		#echo "$i/hooks"

		TP_name=$(echo $i | awk -F/ '{print $NF}')
		echo "$num)-- $TP_name"
		num=$((num + 1))

	done

	read -p "введите цифру: " tempNum
	echo $tempNum
	num=1
	#взять номер шаблона из его порядкового номера
	for i in ~/.yabtm/templates/*; do
		#echo "$i/hooks"
		if [ "$tempNum" -eq "$num" ]; then
			choosen_template=$i	
		fi
		num=$((num + 1))
	done
	printf "you choose $(echo $choosen_template | awk -F/ '{print $NF}')\n\n"
	mkdir yabtm_temp
	echo $choosen_template
	cp -r ~/.yabtm/templates/"$(echo $choosen_template | awk -F/ '{print $NF}')"/. ./yabtm_temp
	sleep 1
	cd yabtm_temp
	ya_btm_render
	cd ..
	cp -r ./yabtm_temp/template/. .
	rm -rf yabtm_temp

fi
