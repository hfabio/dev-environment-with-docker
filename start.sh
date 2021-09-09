#!/bin/bash
# function to clear screen and print a message before next step
clear_and_print()
{
  clear
  echo $1
}
space()
{
  echo
  echo
  echo
}

#making useful directories
clear_and_print 'creating folders'
mkdir ~/PWAs
mkdir ~/Projetos

clear_and_print 'removing lockers'
# removing locks from SO
sudo rm /var/lib/dpkg/lock-frontend; sudo rm /var/cache/apt/archives/lock ;
sudo dpkg --add-architecture i386
sudo dpkg --configure -a

sudo chmod 775 ./*.sh

#setting greeter monitor infos
sudo cp ./OS/monitors.xml ~gdm/.config/
# sudo cp ~/.config/monitors.xml ~gdm/.config/

# first lets update everything
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoclean -y && sudo apt-get autoremove -y

# adding repositories
sudo apt-add-repository ppa:graphics-drivers/ppa -y

#first let's install some stuff to make another stuff work or to controll system
sudo apt-get update && sudo apt install curl -y && sudo apt-get install git zsh vim htop filezilla mc fonts-powerline gnome-tweaks flatpak gnome-software-plugin-flatpak -y
sudo apt-get install ttf-mscorefonts-installer ubuntu-restricted-extras libavcodec-extra libav-tools -y

#python
sudo apt-get install python3.9 pip3 python3-mysql.connector libmysqlclient-dev -y
pip3 install mysqlclient mysql mysql_connector mysql-connector-python-rf --no-cache-dir

# then the IDE, browser and stuffs ---------------------------------------------
# VSCODE
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O /tmp/code_latest_amd64.deb
# github desktop
wget https://github.com/shiftkey/desktop/releases/download/release-2.9.0-linux4/GitHubDesktop-linux-2.9.0-linux4.deb -O /tmp/github_desktop.deb
# TeamViewer
wget -c https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -O /tmp/teamviewer.deb
# google chrome
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google_chrome.deb
# Insync
#wget https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.1.2.40785-bionic_amd64.deb -O /tmp/insync_3.1.2.deb
# Dropbox
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb -O /tmp/dropbox.deb
# skype
# wget https://repo.skype.com/latest/skypeforlinux-64.deb -O /tmp/skypeforlinux.deb
# discord
wget https://dl.discordapp.net/apps/linux/0.0.10/discord-0.0.10.deb -O /tmp/discord.deb
# betterDiscord
wget https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage -O /tmp/BetterDiscord-Linux.AppImage
# 4k video downloader
# wget https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb -O /tmp/4kvideodownloader.deb
# notable
wget https://download.notable.app/\?target\=deb -O /tmp/notable.deb
# komorebi
wget https://github.com/cheesecakeufo/komorebi/releases/download/v2.1/komorebi-2.1-64-bit.deb -O /tmp/komorebi.deb

# now installing .deb stuff ----------------------------------------------------
clear_and_print 'now installing .deb stuff'
sudo chmod 775 /tmp/*.deb
sudo chmod 775 /tmp/*.AppImage
sudo dpkg -i /tmp/*.deb || sudo apt-get --fix-broken install -y && sudo dpkg -i /tmp/*.deb

./tmp/BetterDiscord-Linux.AppImage

# now installing no important stuff like games or music ------------------------
clear_and_print 'now installing no important stuff like games or music'
# removing stuff and adding ppas------------------
sudo apt-get autoremove gimp gimp-plugin-registry
sudo add-apt-repository ppa:otto-kesselgulasch/gimp -y
sudo add-apt-repository ppa:kritalime/ppa -y
sudo add-apt-repository ppa:kdenlive/kdenlive-stable -y
sudo add-apt-repository ppa:lutris-team/lutris -y
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo apt update
# end removing stuff and adding ppas------------------

# gimp
sudo apt-get update
sudo apt-get install gimp -y

# font cascadia
sudo wget https://github.com/microsoft/cascadia-code/releases/download/v1911.21/Cascadia.ttf -O /usr/share/fonts/truetype/Cascadia.ttf
sudo wget https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaMono.ttf -O /usr/share/fonts/truetype/CascadiaMono.ttf
sudo wget https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaMonoPL.ttf -O /usr/share/fonts/truetype/CascadiaMonoPL.ttf

# font menlo for terminal fix
sudo wget https://github.com/abertsch/Menlo-for-Powerline/blob/master/Menlo%20for%20Powerline.ttf -O /usr/share/fonts/truetype/Menlo\ for\ Powerline.ttf

# Steam
sudo apt install steam-installer steam-devices steam:i386 -y

# Wine
sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

# Lutris
sudo apt-get install lutris libvulkan1 libvulkan1:i386 -y

# krita e kdenlive
sudo apt-get install krita kdenlive -y

# blanket
flatpak install flathub com.rafaelmardojai.Blanket

# then the languages/compilers -------------------------------------------------
clear_and_print 'installing dev stuff'
echo "first of all, let's take your .env settings for environment"
sleep 2
./get-env.sh

# installing docker
clear_and_print 'installing docker'
sleep 0.2
./install-docker.sh

# node
clear_and_print 'installing node'
sleep 0.2
./install-node.sh

#-------------------------------------------------------------------------------
# finishing  -------------------------------------------------------------------
clear_and_print 'Another update and then autoclean autoremove'
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoclean -y && sudo apt-get autoremove -y

# lets install
clear_and_print "Let's install zsh with configurated theme\nPay attention, you will need to insert your password here..."

wget https://raw.githubusercontent.com/hfabio/zsh-magic-install/master/zsh-magic-install -O /tmp/zsh-magic-install.sh
sudo chmod 775 /tmp/zsh-magic-install.sh
/tmp/zsh-magic-install.sh

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

cp ./OS/.zshrc ~/.zshrc

chsh -s $(which zsh)

source ~/.zshrc
echo 'be sure to see if all zsh stuff works, tutorial here: https://blog.rocketseat.com.br/terminal-com-oh-my-zsh-spaceship-dracula-e-mais/'

wget -qO- https://raw.githubusercontent.com/hfabio/updater-stuff/master/install.sh | bash

clear_and_print "All setted, now remember to install all gnome-extensions"
space
echo "Clipboard Indicator: https://extensions.gnome.org/extension/779/clipboard-indicator/"
echo "GameMode: https://extensions.gnome.org/extension/1852/gamemode/"
echo "NoAnnoyance: https://extensions.gnome.org/extension/2182/noannoyance/"
echo "Status Area Horizontal Spacing: https://extensions.gnome.org/extension/355/status-area-horizontal-spacing/"
echo "Sound Input & Output Device Chooser: https://extensions.gnome.org/extension/906/sound-output-device-chooser/"
echo "Simple monitor: https://extensions.gnome.org/extension/3891/simple-monitor/"
echo "Removable Drive Menu: https://extensions.gnome.org/extension/7/removable-drive-menu/"
space
read -p 'Ctrl + click to see, and when finished just press enter to finish process!'
