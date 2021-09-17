##
## Ubuntu 20.04 Setup
##
## This is a _modern_ fresh setup that sets up a 20.04 Ubuntu
## machine and get's it to "ready to do work" state that I am
## used to these days.
##

##
## Setup Base Packages
##
if ! [ -f "$HOME/.initial-setup" ]; then
  sudo apt update
  sudo apt install \
    build-essential \
    cmake \
    software-properties-common \
    curl \
    git \
    xclip \
    htop \
    jq \
    tmux \
    silversearcher-ag \
    kitty \
    powerline \
    -y

  echo '
  This file serves as a flag to determine if the initial
  setup has happened from the https://github.com/benfalk/Rx
  setup scripts. This was setup by ubuntu-20.04-setup.sh
  ' > ~/.initial-setup
fi

##
## I drink neovim strait from the tap
##
if ! command -v nvim &> /dev/null; then
  sudo add-apt-repository ppa:neovim-ppa/unstable -y
  sudo apt-get update
  sudo apt install neovim
fi

##
## Albert is my perfered launcher
##
if ! command -v albert &> /dev/null; then
  curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
  echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
  sudo wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O "/etc/apt/trusted.gpg.d/home:manuelschneid3r.asc"
  sudo apt update
  sudo apt install albert -y
fi


##
## asdf does a great job of most language runtime management
##
if ! command -v asdf &> /dev/null; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
  echo '' >> ~/.bashrc
  echo '# asdf langauge runtime manager' >> ~/.bashrc
  echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
  echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
  echo '' >> ~/.bashrc
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

##
## Adding in FiraCode + DevIcons
##
if ! [ -f "/usr/local/share/fonts/truetype/fira-code-font-pack.ttf" ]; then
  wget 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf'
  sudo mkdir -p /usr/local/share/fonts/truetype
  sudo mv 'Fira Code Regular Nerd Font Complete.ttf' \
    /usr/local/share/fonts/truetype/fira-code-font-pack.ttf
  sudo chown root /usr/local/share/fonts/truetype/fira-code-font-pack.ttf
  fc-cache
fi

##
## CoC for Neovim requires nodejs :(
##
if ! command -v node &> /dev/null; then
  asdf plugin add nodejs
  asdf install nodejs lts
  asdf global nodejs lts
fi

##
## Adding My Configs
##
if ! [ -d "$HOME/.dotfiles" ]; then
  git clone https://github.com/benfalk/dotfiles ~/.dotfiles
fi

if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! [ -f "$HOME/.tmux.conf" ]; then
  ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

if ! [ -f "$HOME/.inputrc" ]; then
  ln -sf ~/.dotfiles/inputrc ~/.inputrc
fi

if ! [ -f "$HOME/.bash_aliases" ]; then
  ln -sf ~/.dotfiles/bash_aliases ~/.bash_aliases
fi

if ! [ -f "$HOME/.gitignore_global" ]; then
  ln -sf ~/.dotfiles/gitignore_global ~/.gitignore_global
  git config --global core.excludesfile ~/.gitignore_global
fi

if ! [ -d "$HOME/.config/nvim" ]; then
  mkdir -p ~/.config/nvim/autoload
  mkdir -p ~/.config/nvim/colors
  ln -sf ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
  ln -sf ~/.dotfiles/config/nvim/autoload/utils.vim ~/.config/nvim/autoload/utils.vim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
  mv jellybeans.vim ~/.config/nvim/colors/
  nvim -es -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"
fi

if ! [ -f "$HOME/.config/kitty/kitty.conf" ]; then
  ln -sf ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi

if ! [ -f "$HOME/.config/albert/albert.conf" ]; then
  mkdir -p ~/.config/albert
  ln -sf ~/.dotfiles/config/albert/albert.conf ~/.config/albert/albert.conf
fi

if ! [ -d "$HOME/.local/share/albert" ]; then
  mkdir -p ~/.local/share
  ln -s ~/.dotfiles/local/share/albert ~/.local/share/albert
fi

## `z` lets you jump to directories you use
if ! command -v z &> /dev/null; then
  echo '' >> ~/.bashrc
  echo '# z lets you jump to directories you use' >> ~/.bashrc
  echo '. ~/.dotfiles/z.sh' >> ~/.bashrc
  echo '' >> ~/.bashrc
  . ~/.dotfiles/z.sh
fi
