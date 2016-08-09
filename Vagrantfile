BOX = "ubuntu/trusty" + if ENV["USE_32BIT"] then "32" else "64" end

SSH_FORWARD_SCRIPT = <<-EOH
  set -e

  # Keep $SSH_AUTH_SOCK environment variable in sudo
  file=/etc/sudoers.d/env_keep_ssh_auth_sock
  echo "Defaults    env_keep += \"SSH_AUTH_SOCK\"" > "$file"
  chmod 0440 "$file"

  # Give all users access to ssh agent socket
  if [ ! -z "$SSH_AUTH_SOCK" ]
  then
    chmod a+x $(dirname $SSH_AUTH_SOCK)
    chmod a+rw $SSH_AUTH_SOCK
  fi

  ssh_config=~/.ssh/config
  grep -q 'StrictHostKeyChecking' "$ssh_config" || echo 'StrictHostKeyChecking no' >> "$ssh_config"
  chown -R root:root "$ssh_config"
EOH

PROVISION_SCRIPT = <<-EOH
  set -e
  cd /vagrant
  ./bootstrap
  ./install_berkshelf
  make
  ./solo build "$(cat attributes.json)"
EOH

Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.ssh.forward_agent = true

  config.vm.provision :shell,
    inline: SSH_FORWARD_SCRIPT

  config.vm.provision :shell,
    inline: PROVISION_SCRIPT
end
