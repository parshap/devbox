#!/bin/bash
set -e
DIRNAME=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)

USER=parshap
HOME_PATH="/home/$USER"
HUB_VERSION="2.13.0"
NODE_VERSION="13.6.0"
NODE_DISTRO="linux-armv6l"

# This script is an alternative to the Chef-based setup for Debian-based machines.

apt_install() {
  sudo apt-get install --yes --no-install-recommends $@
}

install_node() {
  # https://unofficial-builds.nodejs.org/download/release/v13.6.0/node-v13.6.0-linux-armv6l.tar.gz
  node_filename="node-v$NODE_VERSION-$NODE_DISTRO.tar.xz"
  curl -O "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/$node_filename"
  # sudo mkdir -p /usr/local/lib/nodejs
  # sudo tar -xJvf $node_filename -C /usr/local/lib/nodejs
  sudo tar --dir=/usr/local --strip-components=1 -xJvf "$node_filename"
  rm $node_filename
}

install_packages() {
  # sudo apt-get update
  apt_install git zsh vim tmux ruby
  # Cleanup
  sudo apt-get autoremove --yes
}

setup_locale() {
  sudo sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
  sudo locale-gen
}

setup_user() {
  # Create user
  zsh_bin=$(which zsh)
  sudo adduser --home "$HOME_PATH" --shell "$zsh_bin" "$USER"
  sudo -u parshap mkdir -p "$HOME_PATH"

  # Passwordless sudo
  sudoers_path="/etc/sudoers.d/$USER"
  echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee "$sudoers_path" > /dev/null
  sudo chown root:root "$sudoers_path"
  sudo chmod a-rw,u+r,g+r "$sudoers_path"

  # Setup ~/.ssh directory
  ssh_path="$HOME_PATH/.ssh"
  sudo -u "$USER" mkdir -p "$ssh_path"
  sudo chmod a-rwx,u+rwx "$ssh_path"

  # Setup authorized_keys
  ssh_authorized_keys_path="$ssh_path/authorized_keys"
  ssh-add -L | sudo tee -a "$ssh_authorized_keys_path" > /dev/null
  sudo chown "$USER":"$USER" "$ssh_authorized_keys_path"
  sudo chmod a-rw,u+rw "$ssh_authorized_keys_path"
}

setup_oh_my_zsh() {
  sudo -u parshap git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME_PATH/.oh-my-zsh"
}

setup_dotfiles() {
  dotfiles_path="$HOME_PATH/projects/dotfiles"
  sudo -u parshap git clone git@github.com:parshap/dotfiles.git "$dotfiles_path"
  (cd "$dotfiles_path" && sudo -Hu $USER make)
}

setup_janus() {
  janus_path="$HOME_PATH/.vim"
  sudo -u parshap git clone git@github.com:carlhuda/janus.git "$janus_path"
  (cd "$janus_path" && sudo -Hu $USER rake)
}

$DIRNAME/script/setup_sudo_ssh_agent.sh
install_packages
install_node
setup_locale
setup_user
setup_oh_my_zsh
setup_dotfiles
setup_janus
$DIRNAME/script/install_hub.sh linux arm "$HUB_VERSION"