require "json"

# Chef run list and attributes
RUN_LIST = %w{git zsh nodejs parshap}
ATTRIBUTES = JSON.parse(File.read("attributes.json"))

Vagrant.configure("2") do |config|
  # Box
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

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
    RUN_LIST.each do |recipe|
      chef.add_recipe recipe
    end
  end
end
