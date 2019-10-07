Vagrant.require_version ">= 2.0.0"

Vagrant.configure(2) do |config|
    # this larger block defines a single machine out of many (TODO)
    config.vm.define "deb0" do |deb0|
        deb0.vm.box = "generic/debian10"
        deb0.vm.hostname = "deb0"
        deb0.vm.provider :virtualbox do |vb|
            # vb.cpus = 2
            vb.memory = 2048
            # for taking DNS from host NAT
            # vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            # unifi starts
            # deb0.vm.network "forwarded_port", guest: 3478, host: 3478
            # deb0.vm.network "forwarded_port", guest: 10001, host: 10001
            # deb0.vm.network "forwarded_port", guest: 8080, host: 8080
            # deb0.vm.network "forwarded_port", guest: 8081, host: 8081
            # deb0.vm.network "forwarded_port", guest: 8443, host: 8443
            # deb0.vm.network "forwarded_port", guest: 8843, host: 8843
            # deb0.vm.network "forwarded_port", guest: 8880, host: 8880
            # deb0.vm.network "forwarded_port", guest: 6789, host: 6789
            # unifi ends
            # TODO: Temporary portforwarding before traefik gets used
            deb0.vm.network "forwarded_port", guest: 9000, host: 9999 # portainer
            deb0.vm.network "forwarded_port", guest: 10002, host: 10002
            deb0.vm.network "forwarded_port", guest: 10000, host: 10000
            deb0.vm.network "private_network", ip: "192.168.99.12"
            # take notes on this in the ansible+vagrant notes document
            # taken from : http://bit.ly/2Hy04DN
            # config.vm.define "test-deb-server"
            # config.ssh.insert_key = false
            deb0.vm.provision "ansible" do |ansible|
                ansible.playbook = "tests/prepare.yml"
                # ansible.inventory_path = "inventories/test-workstation/hosts"
            end
        end
    end
end
