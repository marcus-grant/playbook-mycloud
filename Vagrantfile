Vagrant.require_version ">= 2.0.0"

Vagrant.configure(2) do |config|
    # config.vm.box = "archlinux-gnome"
    config.vm.box = "generic/debian10"
    # TODO: Temporary portforwarding before traefik gets used
    config.vm.network "forwarded_port", guest: 9000, host: 9000
    config.vm.network "private_network", ip: "192.168.99.12"
    # take notes on this in the ansible+vagrant notes document
    # taken from : http://bit.ly/2Hy04DN
    # config.vm.define "test-deb-server"
    # config.ssh.insert_key = false
    config.vm.provider :virtualbox do |vb|
        vb.cpus = 2
        vb.memory = 4096
        # for taking DNS from host NAT
        # vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        # v.gui = true
        # v.name = "test-workstation"
    end
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/prepare.yml"
        # ansible.inventory_path = "inventories/test-workstation/hosts"
    end
end