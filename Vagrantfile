require "json"

BOX = if ENV["USE_32BIT"] then "precise32" else "precise64" end
ATTRIBUTES = JSON.parse(File.read("attributes.json"))

Vagrant.configure("2") do |config|
  # Box
  config.vm.box = BOX
  config.vm.box_url = "http://files.vagrantup.com/#{BOX}.box"

  # SSH
  config.ssh.forward_agent = true

  # Give all users access to ssh agent socket
  config.vm.provision :shell do |shell|
    shell.inline = <<-EOH
        chmod a+x $(dirname $SSH_AUTH_SOCK)
        chmod a+rw $SSH_AUTH_SOCK
    EOH
  end

  # Provision
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    chef.json = ATTRIBUTES
    chef.add_recipe "parshap"
  end
end
