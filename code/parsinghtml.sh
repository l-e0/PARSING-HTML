#!/bin/bash

red='\033[0;91m'
reset='\033[0m'

echo -e "${red}"
echo "        ,     \\    /     ,        "
echo "       / \\    )\\__/(    / \\       "
echo "      /   \\  (@\\  /@)  /   \\      "
echo " ____/_____\__\\ .. /__/_____\____ "
echo "|             |\\__/|             |"
echo "|              \\VV/              |"
echo "|  '.\\|/.'      ''      '.\\|/.'  |"
echo "|  - -O- - PARSING HTML - -O- -  |"
echo "|  .'/|\\'.   BY: le-0   .'/|\\'.  |"
echo "|________________________________|"
echo " |    /\\ /      \\\\     \\  /\\    | "
echo " |  /   V        ))      V   \\  | "
echo " |/     '       //       '     \\| "
echo " '              V               '  "

echo -e "${reset}"

if [ "$1" == "" ]; then 
    echo -e "\033[1;38;2;0;255;0mModo de uso: $0 URL\033[0m"
    echo -e "\033[1;38;2;0;255;0mExemplo: $0 www.google.com\033[0m"
else
   
    echo -e "\033[1;38;2;0;255;0mAguarde...\033[0m"

    erro=false
    for url in "$@"; do  
        wget -qO- "$url" | grep -a href | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" > lista
    done 
    
       if [ ! -s lista ]; then
        erro=true
        echo -e "\033[1;31mERRO! URL não encontrada ou incorreta, tente outra url: $url\033[0m"
    fi
    
    while read -r url; do
        ip=$(host "$url" | awk '/has address/ {print $NF}')
        if [ "$url" == "icon" ] && [ -z "$ip" ]; then
            erro=true
            echo -e "\033[1;31mERRO! URL não encontrada ou incorreta, tente outra url: $url\033[0m"
        elif [ -n "$ip" ]; then
            echo -e "URL: $url IP: $ip"
        fi
    done < lista

    rm lista
fi
