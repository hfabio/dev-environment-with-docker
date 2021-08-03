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
echo "Now let's set your git configs"
echo
echo -n "Your name: "
read name
git config --global user.name "$name"
echo -n "Your email: "
read email
git config --global user.email "$email"
echo -n "Your text editor for git: "
read editor
git config --global core.editor "$editor"
# echo "$(cat .env)"
space
echo "Check if git was correctly configured:"
git config --global user.name
git config --global user.email
git config --global core.editor
read -p "Press enter to continue"
space
echo 'Configuration done'
read -p "Press enter to continue"