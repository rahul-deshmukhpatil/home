script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -s $script_dir/screenrc ~/.screenrc 
ln -s $script_dir/vimrc ~/.vimrc

sudo aptitude install --assume-yes git

mkdir -p ~/.local/bin/
cp $script_dir/local/bin/* ~/.local/bin/

git config --global user.email "rahul.deshmukhpatil@gmail.com"
git config --global user.name "rahul patil"

echo "" >> ~/.bashrc
echo ". $script_dir/bashrc" >> ~/.bashrc

source ~/.bashrc

bash -x $script_dir/install_packages.sh


