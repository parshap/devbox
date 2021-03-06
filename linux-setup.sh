#!/bin/bash
set -e
DIRNAME=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)

USER=parshap
HOME_PATH="/home/$USER"
HUB_VERSION="2.14.2"
HUB_PLATFORM="linux"
HUB_ARCH="amd64"
NODE_VERSION="15.x"

# This script is an alternative to the Chef-based setup for Debian-based machines.

apt_install() {
  sudo apt-get install --yes --no-install-recommends $@
}

install_node() {
  curl -sL https://deb.nodesource.com/setup_"$NODE_VERSION" | sudo -E bash -
  sudo apt-get install -y nodejs
}

install_packages() {
  sudo apt-get update
  apt_install build-essential net-tools git zsh vim tmux ruby
  # Cleanup
  sudo apt-get autoremove --yes
}

setup_user() {
  # Create user
  zsh_bin=$(which zsh)
  sudo adduser --disabled-password --gecos "" --home "$HOME_PATH" --shell "$zsh_bin" "$USER"
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
  ssh_pub_key_file=~/.ssh/id_rsa.pub
  if [[ -f "$ssh_pub_key_file" ]]; then
    cat "$ssh_pub_key_file" | sudo tee -a "$ssh_authorized_keys_path" > /dev/null
  else
    ssh-add -L | sudo tee -a "$ssh_authorized_keys_path" > /dev/null
  fi

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
setup_user
setup_oh_my_zsh
setup_dotfiles
setup_janus
$DIRNAME/script/install_hub.sh "$HUB_PLATFORM" "$HUB_ARCH" "$HUB_VERSION"
