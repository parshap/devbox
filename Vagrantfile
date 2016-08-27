BOX = "ubuntu/trusty" + if ENV["32BIT"] then "32" else "64" end
MEMORY = (ENV["VM_MEMORY"] or 1024).to_i
CPUS = (ENV["VM_CPUS"] or 1).to_i

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

  config.vm.provider "virtualbox" do |vm|
    vm.memory = MEMORY
    vm.cpus = CPUS
  end

  config.vm.provision :shell,
    inline: SSH_FORWARD_SCRIPT

  config.vm.provision :shell,
    inline: PROVISION_SCRIPT
end
