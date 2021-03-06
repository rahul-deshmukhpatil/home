#!/bin/bash
sudo apt-get install aptitude
sudo aptitude install --assume-yes curl screen htop vim vlc cmake tree git libboost-dev libboost-filesystem-dev python3-pip net-tools
sudo aptitude install --assume-yes silversearcher-ag tldr 

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/plugged
sudo aptitude install --assume-yes python3-dev cmake
~/.vim/plugged/youcompleteme/install.py  --clang-completer --clangd-completer --system-boost --enable-coverage --build-dir /tmp
