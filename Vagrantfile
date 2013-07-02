require "json"

# Chef run list and attributes
RUN_LIST = %w{git zsh nodejs parshap}
ATTRIBUTES = JSON.parse(File.read("attributes.json"))

Vagrant.configure("2") do |config|
  # Box
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

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
