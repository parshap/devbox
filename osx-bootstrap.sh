# Make ~/projects directory
mkdir ~/projects

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install packages using brew
brew install \
	ruby \
	zsh \
	git \
	node \
	tmux \
	hub \
	gist \
	homebrew/dupes/less

# Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Install Janus
git clone git@github.com:carlhuda/janus.git ~/.vim
(cd ~/.vim; rake)

# Install dotfiles
git clone git@github.com:parshap/dotfiles.git ~/projects/dotfiles
(cd ~/projects/dotfiles; make)

# Install homebrew cask
brew install caskroom/cask/brew-cask

# Install cask packages
brew cask install \
	google-chrome \
	firefox \
	virtualbox \
	vagrant
