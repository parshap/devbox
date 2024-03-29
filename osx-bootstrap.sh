#!/bin/bash
set -e

# Additioanl things to do:
#
# set trackpad speed
# turn on auto dark mode
# turn on night mode automatic (or custom)
# set keyboard delay
# set terminal default theme font (sf mono regular 14)
# create ~/.ssh dir
# get ssh key

# Make ~/projects directory
mkdir -p ~/projects

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install packages using brew
brew install \
	less \
	zsh \
	vim \
	tmux \
	git \
	node \
	gh \
	gist \
	jq

brew cask install google-chrome

# Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Change shell to zsh
chsh -s $(which zsh)

# Install Janus
git clone git@github.com:carlhuda/janus.git ~/.vim
(cd ~/.vim; rake)

# Install dotfiles
git clone git@github.com:parshap/dotfiles.git ~/projects/dotfiles
(cd ~/projects/dotfiles; make)
