##
## Ubuntu Setup
##
## This will get you up and running with an environment that is similiar to the one
## I use every day, as I find or add items I try to keep this up to date
##

# Base up and running...
sudo apt-get update -y
sudo apt-get install build-essential -y
sudo apt-get install cmake -y
sudo apt-get install python-software-properties -y
sudo apt-get install python-dev -y
sudo apt-get install curl -y
sudo apt-get install git -y
sudo apt-get install xclip -y
sudo apt-get install phantomjs -y
sudo apt-get install htop -y
sudo apt-get install multitail -y
sudo apt-get install parallel -y

# Latest Nodejs
sudo add-apt-repository ppa:chris-lea/node.js -y
sudo apt-get update -y
sudo apt-get install nodejs -y

# Core development set
sudo apt-get install vim-gnome -y
sudo apt-get install konsole -y
sudo apt-get install tmux -y
sudo apt-get install finch -y
sudo apt-get install silversearcher-ag -y

# Erlang & Elixir
curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
chmod 775 kerl
sudo chown root:root kerl
sudo mv kerl /usr/bin
kerl build 17.4 17_4
kerl install 17_4 ~/.erlang_builds/17_4/

# Powerline
sudo apt-get install python-pip -y
pip install --user git+git://github.com/Lokaltog/powerline
echo '
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi' >> ~/.profile
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# I'm moving in!
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/benfalk/dotfiles ~/.dotfiles
if [ -f ~/.bashrc ]; then
	cp ~/.bashrc ~/.bashrc.bkup
fi
ln -sf ~/.dotfiles/bashrc ~/.bashrc
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/inputrc ~/.inputrc
ln -sf ~/.dotfiles/bash_aliases ~/.bash_aliases

# In depth vim setup
ln -sf ~/.dotfiles/vimrc ~/.vimrc
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/Lokaltog/vim-distinguished/develop/colors/distinguished.vim
mv distinguished.vim ~/.vim/colors/
mkdir -p ~/.vim/autoload ~/.vim/bundle &vim +PluginInstall +qall& \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/rking/ag.vim ~/.vim/bundle/ag
vim +PluginInstall +qall

# Mutate
sudo add-apt-repository ppa:mutate/ppa
sudo apt-get update
sudo apt-get install libboost-regex1.55-dev
sudo apt-get install mutate

# Core environment
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.2
sudo apt-get install nginx -y
sudo apt-get install postgresql-9.4 postgresql-server-dev-9.4 postgresql-contrib-9.4 -y
sudo apt-get install redis-server -y
sudo apt-get install libmagickwand-dev -y
