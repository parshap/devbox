#!/usr/bin/env bash

# Originally from https://gist.github.com/ruliana/5079371
# This script will bootstrap a machine with Ruby and Chef

# apt-get update once per day
touch -d "-1 day" /tmp/apt_update_limit
if [ /tmp/apt_update_limit -nt /tmp/apt_update_last ]
then
	sudo apt-get -y update
	touch /tmp/apt_update_last
fi

# Install deps
sudo apt-get --no-install-recommends -y install \
	build-essential \
	wget \
	curl

# Install Ruby 2.0.0-p247
ruby_version=2.0.0-p247
ruby_version_current=$(ruby -e 'puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"')
if [ "$ruby_version_current" != "$ruby_version" ]
then
	ruby_name=ruby-$ruby_version
	ruby_file=$ruby_name.tar.gz
	cd /tmp
	wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/$ruby_file
	tar -xvzf $ruby_file
	cd $ruby_name
	./configure --prefix=/usr/local
	make
	sudo make install
fi

# Install Chef 11.4.4
chef_version=11.4.4
chef_version_current=$(chef-solo --version | awk ' { sub(/Chef: /, ""); print }')
if [ "$chef_version_current" != "$chef_version" ]
then
	chef_install=https://www.opscode.com/chef/install.sh
	curl -L $chef_install -v 11.4.4_2 | sudo bash
fi

# Install Berkshelf
sudo apt-get --no-install-recommends -y install \
	libxml2-dev \
	libxslt-dev
sudo gem install berkshelf
