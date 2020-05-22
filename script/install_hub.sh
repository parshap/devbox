#!/bin/bash

# Usage:
#
#     install_hub.sh linux amd64 2.2.4
#

platform=$1
arch=$2
version=$3

curl -L http://github.com/github/hub/releases/download/v$version/hub-$platform-$arch-$version.tgz | \
	sudo tar --dir=/usr/local --strip-components=1 -zxvf -
