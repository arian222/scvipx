#!/bin/bash
# https://t.me/gemilangkinasih

rm -rf "$0" 2>/dev/null
rm -rf sogokupdate.sh 2>/dev/null

clear
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "\033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "\033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}
res1() {
    cd /root
    wget -q https://raw.githubusercontent.com/arian222/scvipx/main/sogokmenu/menu.zip
    unzip menu.zip
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip
}
netfilter-persistent
clear
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e "\E[40;1;37m       UPDATE AUTOSCRIPT IN PROCESS       \E[0m"
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e ""
echo -e "\033[1;91mUpdate Script Service\033[1;37m"
fun_bar 'res1'
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e ""
read -n 1 -s -r -p "Press [ Enter ] To Back On Menu"
menu