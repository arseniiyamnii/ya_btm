#!/bin/bash
if [ $1 = "showall" ]; then
    for i in ~/.yabtm/templates/*; do
        echo "$i/hooks"
        if [ -d "$i/hooks" ]; then 
            TP_name=$(echo $i | awk -F/ '{print $NF}')
            echo "Hooks from $TP_name"
            ls "$i"/hooks
        fi
    done
fi
if [ $1 = "showfrom" ]; then 
    if [ -d "$HOME/.yabtm/templates/$2/hooks" ]; then 
        TP_name=$(echo $2 | awk -F/ '{print $NF}')
        echo "Hooks from $TP_name"
        ls $HOME/.yabtm/templates/"$2"/hooks
    else
        echo "in template $2 ZERO hooks))"
    fi
fi

if [ $1 = "usefrom" ]; then 
    bash -c "~/.yabtm/templates/$2/hooks/$3"
fi

if [ $1 = "chooser" ]; then 
    echo "choose your template: "
    num=1
    #вывод списка шаблонов
    for i in ~/.yabtm/templates/*; do
        #echo "$i/hooks"
        if [ -d "$i/hooks" ]; then 
            TP_name=$(echo $i | awk -F/ '{print $NF}')
            echo "$num)-- $TP_name"
            num=$((num+1))
        fi
    done

    read -p "введите цифру: " tempNum
    num=1
    #взять номер шаблона из его порядкового номера
    for i in ~/.yabtm/templates/*; do
        #echo "$i/hooks"
        if [ -d "$i/hooks" ]; then 
            if [ $tempNum -eq $num ]; then
                choosen_template=$i
                num=$((num+1))
            fi
        fi
    done
    printf "you choose $(echo $choosen_template | awk -F/ '{print $NF}')\n\n"
    echo "теперь выберите хук: "
    num=1
    for i in $choosen_template/hooks/*; do
        echo "$num) -- $(echo $i | awk -F/ '{print $NF}')"
        num=$((num+1))
    done
    read -p "Введите цифру: " hook_num
    num=1
    for i in $choosen_template/hooks/*; do
        if [ $hook_num -eq $num ]; then
            choosen_hook=$i
        fi
        #echo "$num) -- $(echo $i | awk -F/ '{print $NF}')"
        num=$((num+1))
    done
    echo "Вы выбрали хук $choosen_hook"
    echo Запуск
    bash -c "$choosen_hook"
    echo Готово

fi
if [ $1 = "help" ] || [ $1 = "--help" ]; then
cat << EOF
	usage: ya_brm.sh [command][options]
	commands:
	help - this help
	showall
	usefrom
	showfrom
	chooser
EOF

fi

