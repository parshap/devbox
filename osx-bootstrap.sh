# Make ~/projects directory
mkdir ~/projects

# Install Brew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor

# Install software using brew
brew install git
brew install tmux
brew install node
brew install hub
brew install zsh

# Install less (for lesskey)
(
	cd /tmp
	curl http://www.greenwoodsoftware.com/less/less-458.tar.gz | tar -zxf -
	cd less-458
	./configure
	sudo make install
)

# Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Install Janus
git clone git@github.com:carlhuda/janus.git ~/.vim
(cd ~/.vim; rake)

# Install dotfiles
git clone git@github.com:parshap/dotfiles.git ~/projects/dotfiles
(cd ~/projects/dotfiles; make)

# Install homebrew-cask
brew tap phinze/cask
brew install brew-cask

# Install Google Chrome
brew cask install google-chrome

# Install Firefox
brew cask install firefox

# Install Virtual Box
brew cask install virtualbox

# Install Vagrant
brew cask install vagrant
