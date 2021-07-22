#!/bin/bash
cp .env.example .env

space()
{
    echo
    echo
    echo
    echo
}

read_secret()
{
    stty -echo
    trap 'stty echo' EXIT
    read "$@"
    stty echo
    trap - EXIT
    echo
}

shopt -s nocasematch

for line in $(cat .env); do
    sanitized=$(echo $line | cut -d'=' -f 1)
    echo "digite o novo valor de $sanitized"
    if [[ "$line" =~ (password|pwd) ]]; then
        echo -n "secret: "
        read_secret valor
        sed -i -e "s/${line}/${line}${valor}/g" .env
    else
        echo -n "value: "
        read valor
        sed -i -e "s/${line}/${line}${valor}/g" .env
    fi
done

clear
echo 'Finished environment set'
space
echo "$(cat .env)"
space
read -p "Press enter to continue"