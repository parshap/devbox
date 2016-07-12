BOX = "ubuntu/trusty" + if ENV["USE_32BIT"] then "32" else "64" end
PROVISION_SCRIPT = <<-EOH
  set -e

  # Give all users access to ssh agent socket
  if [ ! -z "$SSH_AUTH_SOCK" ]
  then
    chmod a+x $(dirname $SSH_AUTH_SOCK)
    chmod a+rw $SSH_AUTH_SOCK
  fi

  # Run Chef
  cd /vagrant
  ./bootstrap
  ./install_berkshelf
  make
  ./solo build "$(cat attributes.json)"
EOH

Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.ssh.forward_agent = true

  config.vm.provision :shell do |shell|
    shell.inline = PROVISION_SCRIPT
  end
end
