BOX = if ENV["USE_32BIT"] then "precise32" else "precise64" end
PROVISION_SCRIPT = <<-EOH
  # Give all users access to ssh agent socket
  chmod a+x $(dirname $SSH_AUTH_SOCK)
  chmod a+rw $SSH_AUTH_SOCK

  # Run Chef
  cd /vagrant
  ./bootstrap.sh
  ./solo.sh build "$(cat attributes.json)"
EOH

Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.vm.box_url = "http://files.vagrantup.com/#{BOX}.box"
  config.ssh.forward_agent = true

  config.vm.provision :shell do |shell|
    shell.inline = PROVISION_SCRIPT
  end
end
