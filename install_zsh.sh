# https://www.youtube.com/watch?v=wM1uNqj71Ko
# https://medium.com/@alex285/get-powerlevel9k-the-most-cool-linux-shell-ever-1c38516b0caa



#install ZSH
sudo aptitude -y install zsh
#change ZSH to be default shell
chsh -s $(which zsh)



#install  OH-MY-ZSH
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



#install powerlevel9k
#add the theme  ZSH_THEME="powerlevel9k/powerlevel9k" in ~/.zshrc
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k



#install ZSH autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions



#install ZSH fuzzy search
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install



#install ZSH syntax highlighting
sudo aptitude -y install zsh-syntax-highlighting
