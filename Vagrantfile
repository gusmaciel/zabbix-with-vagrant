Vagrant.configure("2") do |config|
  
  config.vm.box = "debian/bookworm64"
  config.vm.hostname = "zabbix"

  config.vm.network "private_network", ip: "192.168.56.10"

   config.vm.provider "virtualbox" do |vb|
    vb.name = "ZABBIX"
    vb.memory = "2048"
    vb.cpus = 2
   end

  # Provisioning script para instalação e configuração do Zabbix
  config.vm.provision "shell", path: "provision.sh"

end