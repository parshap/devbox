BOX = "generic/ubuntu2004"
MEMORY = (ENV["VM_MEMORY"] or 8192).to_i
CPUS = (ENV["VM_CPUS"] or 2).to_i

DISABLE_STRICT_HOST_KEY_CHECKING_SCRIPT = <<-EOH
  set -e
  ssh_config=~/.ssh/config
  grep -q 'StrictHostKeyChecking' "$ssh_config" || echo 'StrictHostKeyChecking no' >> "$ssh_config"
  chown -R root:root "$ssh_config"
EOH

PROVISION_SCRIPT = <<-EOH
  set -e
  cd /vagrant
  ./linux-setup.sh
EOH

Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vm|
    vm.memory = MEMORY
    vm.cpus = CPUS
  end

  config.vm.provider "hyperv" do |vm|
    vm.maxmemory = MEMORY
    vm.cpus = CPUS
  end

  config.vm.network "public_network",
    use_dhcp_assigned_default_route: true

  config.vm.provision :shell,
    inline: DISABLE_STRICT_HOST_KEY_CHECKING_SCRIPT

  config.vm.provision :shell,
    inline: PROVISION_SCRIPT
end
