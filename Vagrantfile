Vagrant.require_version ">= 2.0.0"

Vagrant.configure(2) do |config|
    # config.vm.box = "archlinux-gnome"
    config.vm.box = "generic/debian10"
    # config.ssh.insert_key = false
    config.vm.provider "virtualbox" do |v|
        v.cpus = 2
        v.memory = 4096
        # v.gui = true
        # v.name = "test-workstation"
    end
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/prepare.yml"
        # ansible.inventory_path = "inventories/test-workstation/hosts"
    end
end