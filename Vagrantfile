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
  config.vm.provision "shell", inline: <<-SHELL
    set -e
    
    # Atualizar lista de pacotes
    sudo apt update
    
    # Instalar curl
    sudo apt install -y curl
    
    # Instalar locales
    sudo apt install -y locales
    sudo dpkg-reconfigure -f noninteractive locales
    
    # Configurar repositório MariaDB
    wget -q https://r.mariadb.com/downloads/mariadb_repo_setup -O /tmp/mariadb_repo_setup
    chmod +x /tmp/mariadb_repo_setup
    sudo /tmp/mariadb_repo_setup
    
    # Instalar MariaDB
    sudo apt install -y mariadb-server
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    
    # Configurar repositório Zabbix
    wget -q https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb -O /tmp/zabbix-release_latest_7.4+debian12_all.deb
    sudo dpkg -i /tmp/zabbix-release_latest_7.4+debian12_all.deb
    
    # Atualizar lista de pacotes novamente
    sudo apt update
    
    # Instalar componentes Zabbix
    sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
    
    # Criar banco de dados e usuário Zabbix
    sudo mysql -e "CREATE DATABASE IF NOT EXISTS zabbix character set utf8mb4 collate utf8mb4_bin;"
    sudo mysql -e "CREATE USER IF NOT EXISTS 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
    sudo mysql -e "FLUSH PRIVILEGES;"
    
    # Importar schema do banco de dados
    sudo zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | sudo mysql --default-character-set=utf8mb4 -uzabbix -pzabbix zabbix
    
    # Configurar Zabbix Server
    sudo sed -i 's/# DBPassword=/DBPassword=zabbix/' /etc/zabbix/zabbix_server.conf
    
    # Iniciar e habilitar serviços
    sudo systemctl start zabbix-server zabbix-agent apache2
    sudo systemctl enable zabbix-server zabbix-agent apache2
    sudo systemctl restart apache2
    
    echo "Zabbix instalado e configurado com sucesso!"
  SHELL

end