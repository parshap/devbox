#!/bin/bash
set -e

# Make ~/projects directory
mkdir -p ~/projects

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install packages using brew
brew install \
	ruby \
	python \
	zsh \
	git \
	node \
	tmux \
	hub \
	gist \
	homebrew/dupes/less \
	reattach-to-user-namespace \
	jq \
	md5sha1sum \
	google-chrome \
	firefox \
	virtualbox \
	vagrant

# Install vim (and override system vim)
brew install vim --override-system-vim
ln -s /usr/local/bin/vim /usr/local/bin/vi

# Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Install Janus
git clone git@github.com:carlhuda/janus.git ~/.vim
(cd ~/.vim; rake)

# Install dotfiles
git clone git@github.com:parshap/dotfiles.git ~/projects/dotfiles
(cd ~/projects/dotfiles; make)
