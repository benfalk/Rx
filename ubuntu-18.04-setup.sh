##
## Ubuntu 18.04 Setup
##
## This should take a fresh install of 18.04 and set it to work exactly like
## my development machine that I use every day.
##

## Base Packages
if ! [ -f "$HOME/.initial-setup" ]; then
  sudo apt update
  sudo apt install build-essential -y
  sudo apt install cmake -y
  sudo apt install python-software-properties -y
  sudo apt install python-dev -y
  sudo apt install curl -y
  sudo apt install git -y
  sudo apt install xclip -y
  sudo apt install htop -y
  sudo apt install jq -y
  sudo apt install wmctrl suckless-tools -y
  sudo apt install tmux -y
  sudo apt install silversearcher-ag -y
  sudo apt install fonts-firacode -y
  echo '
  This file serves as a flag to determine if the initial
  setup has happened from the https://github.com/benfalk/Rx
  setup scripts
  ' > ~/.initial-setup
fi

## Powerline: The eye candy for tmux and terminal
if ! type "powerline" > /dev/null; then
  sudo apt-get install python-pip -y
  pip install --user git+git://github.com/Lokaltog/powerline
  echo '
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi' >> ~/.profile
  wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf \
       https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
  mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
  fc-cache -vf ~/.fonts
  mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fi

## Bringing In Base Configurations
if ! [ -d "$HOME/.dotfiles" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  git clone https://github.com/benfalk/dotfiles ~/.dotfiles
  if [ -f ~/.bashrc ]; then
    cp ~/.bashrc ~/.bashrc.bkup
  fi
  ln -sf ~/.dotfiles/bashrc ~/.bashrc
  ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
  ln -sf ~/.dotfiles/inputrc ~/.inputrc
  ln -sf ~/.dotfiles/bash_aliases ~/.bash_aliases
  ln -sf ~/.dotfiles/gitignore_global ~/.gitignore_global
  git config --global core.excludesfile ~/.gitignore_global
fi

## Install Neovim, Editor of Choice
if ! type "nvim" > /dev/null; then
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install neovim python3-pip -y
  pip3 install neovim
  mkdir -p ~/.config/nvim/autoload
  mkdir -p ~/.config/nvim/colors
  ln -sf ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
  ln -sf ~/.dotfiles/config/nvim/autoload/utils.vim ~/.config/nvim/autoload/utils.vim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  wget https://raw.githubusercontent.com/Lokaltog/vim-distinguished/develop/colors/distinguished.vim
  mv distinguished.vim ~/.config/nvim/colors/
fi

## Pour out a 40 for Mutate; I loved it, but Albert works out of the box with 18.04
if ! type "albert" > /dev/null; then
  sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
  sudo apt-get update
  sudo apt-get install albert
  mkdir -p ~/.config/albert/
  ln -sf ~/.dotfiles/config/albert/albert.conf ~/.config/albert/albert.conf
  ln -sf ~/.dotfiles/local/share/albert ~/.local/share/albert
fi

## My new Favorite Terminal
if ! type "kitty" > /dev/null; then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  sudo ln -sf ~/.local/kitty.app/bin/kitty /bin/kitty
  ln -sf ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi

## Elixir/Erlang Development Language
if ! type "elixir" > /dev/null; then
  (cd ~/ && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb)
  (cd ~/ && sudo dpkg -i erlang-solutions_1.0_all.deb)
  sudo apt update
  sudo apt install esl-erlang -y
  sudo apt install elixir -y
fi

## Docker: The hype is "mostly" real
if ! type "docker" > /dev/null; then
  sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common -y

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

  sudo apt update
  sudo apt-get install docker-ce docker-ce-cli containerd.io

  sudo usermod -aG docker $(whoami)
  sudo echo "{\"userns-remap\":\"$(whoami)\"}" | sudo tee /etc/docker/daemon.json > /dev/null
  echo "$(whoami):1000:1" | sudo tee -a /etc/subgid > /dev/null
  echo "$(whoami):1000:1" | sudo tee -a /etc/subuid > /dev/null

  sudo curl -L \
    "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose

  sudo chmod +x /usr/local/bin/docker-compose

  sudo curl \
    -L https://raw.githubusercontent.com/docker/compose/1.24.0/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose
fi
