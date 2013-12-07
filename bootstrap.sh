#!/usr/bin/env bash

# Originally from https://gist.github.com/ruliana/5079371
# This script will bootstrap a machine with Ruby and Chef

apt_install() {
	sudo apt-get install --yes --no-install-recommends $@
}

# Install add-apt-repository
apt_install python-software-properties

# Add Ruby PPA
sudo add-apt-repository ppa:brightbox/ruby-ng-experimental

# apt-get update once per day
touch -d "-1 day" /tmp/apt_update_limit
if [ /tmp/apt_update_limit -nt /tmp/apt_update_last ]
then
	sudo apt-get -y update
	touch /tmp/apt_update_last
fi

# Install Ruby
apt_install ruby2.0 ruby2.0-dev

# Install build tools
apt_install build-essential

# Install Chef
chef_version=11.8.2
chef_version_current=$(sudo chef-solo --version | awk ' { sub(/Chef: /, ""); print }')
if [ "$chef_version_current" != "$chef_version" ]
then
	sudo gem install --no-ri --no-rdoc chef -v $chef_version
fi

# SmartOS notes
# pkgin -y install gcc47 gcc47-runtime gmake
# gem install --no-ri --no-rdoc chef
