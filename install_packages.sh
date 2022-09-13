#!/bin/bash
sudo apt-get install aptitude
sudo aptitude install --assume-yes curl screen htop vim vlc cmake tree rename git libboost-dev libboost-filesystem-dev python3-pip net-tools rlwrap
sudo aptitude install --assume-yes silversearcher-ag tldr fzf 

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/plugged
sudo aptitude install --assume-yes python3-dev cmake
~/.vim/plugged/youcompleteme/install.py  --clang-completer --clangd-completer --system-boost --enable-coverage --build-dir /tmp



# pypy
# its available
#sudo add-apt-repository ppa:pypy/ppa
sudo apt update
sudo apt install pypy3

#for jetbrains toolbox
sudo aptitude install --assume-yes libfuse2

#install ms courier font
 sudo apt install ttf-mscorefonts-installer
