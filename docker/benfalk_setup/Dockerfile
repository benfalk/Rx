FROM ubuntu:15.04
MAINTAINER Ben Falk <benjamin.falk@yahoo.com>

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Base System
RUN apt-get update -y
RUN apt-get install build-essential -y
RUN apt-get install cmake -y
RUN apt-get install python-software-properties -y
RUN apt-get install software-properties-common -y
RUN apt-get install python-dev -y
RUN apt-get install curl -y
RUN apt-get install wget -y
RUN apt-get install git -y
RUN apt-get install phantomjs -y
RUN apt-get install htop -y

# Tmux Latest
RUN add-apt-repository ppa:pi-rho/dev -y
RUN apt-get update -y
RUN apt-get install tmux -y

# Add User
RUN adduser --disabled-password --gecos "" bfalk
RUN apt-get install sudo -y

# Core Development
RUN apt-get install vim -y
RUN apt-get install silversearcher-ag -y
RUN sudo -H -u bfalk git clone https://github.com/tmux-plugins/tpm /home/bfalk/.tmux/plugins/tpm
RUN sudo -H -u bfalk git clone https://github.com/benfalk/dotfiles /home/bfalk/.dotfiles 
RUN sudo -H -u bfalk ln -sf /home/bfalk/.dotfiles/bashrc /home/bfalk/.bashrc
RUN sudo -H -u bfalk ln -sf /home/bfalk/.dotfiles/tmux.conf /home/bfalk/.tmux.conf
RUN sudo -H -u bfalk sed -i s/^source.*$//g  /home/bfalk/.tmux.conf
RUN sudo -H -u bfalk ln -sf /home/bfalk/.dotfiles/inputrc /home/bfalk/.inputrc
RUN sudo -H -u bfalk ln -sf /home/bfalk/.dotfiles/bash_aliases /home/bfalk/.bash_aliases
RUN sudo -H -u bfalk ln -sf /home/bfalk/.dotfiles/gitignore_global /home/bfalk/.gitignore_global
RUN sudo -H -u bfalk git config --global core.excludesfile /home/bfalk/.gitignore_global
RUN sudo -H -u bfalk ln -sf /home/bfalk/.dotfiles/vimrc /home/bfalk/.vimrc
RUN sudo -H -u bfalk mkdir -p /home/bfalk/.vim/autoload
RUN sudo -H -u bfalk ln -sf /home/bfalk/.dotfiles/vim/autoload/netrw.vim /home/bfalk/.vim/autoload/netrw.vim
RUN sudo -H -u bfalk mkdir -p /home/bfalk/.vim/colors
RUN sudo -H -u bfalk sh -c "cd /home/bfalk/.vim/colors && wget https://raw.githubusercontent.com/Lokaltog/vim-distinguished/develop/colors/distinguished.vim"
RUN sudo -H -u bfalk curl -LSso /home/bfalk/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
RUN sudo -H -u bfalk git clone https://github.com/gmarik/Vundle.vim.git /home/bfalk/.vim/bundle/Vundle.vim
RUN sudo -H -u bfalk git clone https://github.com/scrooloose/nerdtree.git /home/bfalk/.vim/bundle/nerdtree
RUN sudo -H -u bfalk git clone https://github.com/rking/ag.vim /home/bfalk/.vim/bundle/ag
RUN sudo -H -u bfalk vim +PluginInstall +qall
