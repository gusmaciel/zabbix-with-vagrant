#!/bin/bash

# Atualiza o sistema
apt update
apt upgrade -y

# Instala dependências
apt install -y wget curl gnupg2 lsb-release ca-certificates software-properties-common

# Adiciona repositório do Zabbix 7.4
wget -q https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb

dpkg -i zabbix-release_latest_7.4+debian12_all.deb

apt update

# Instala MariaDB
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash

apt update

apt install -y mariadb-server

# Inicia MariaDB
systemctl enable mariadb
systemctl start mariadb

# Configura banco do Zabbix
mysql <<EOF
CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix123';

GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';

FLUSH PRIVILEGES;
EOF

# Instala componentes do Zabbix
apt install -y \
    zabbix-server-mysql \
    zabbix-frontend-php \
    zabbix-apache-conf \
    zabbix-sql-scripts \
    zabbix-agent

# Importa schema inicial
zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | \
mysql --default-character-set=utf8mb4 -uzabbix -pzabbix123 zabbix

# Configura senha do banco no Zabbix
sed -i 's/^# DBPassword=/DBPassword=zabbix123/' /etc/zabbix/zabbix_server.conf

# Garante locale UTF-8
apt install -y locales

sed -i 's/^# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen

locale-gen

# Reinicia serviços
systemctl restart mariadb
systemctl restart apache2
systemctl restart zabbix-server
systemctl restart zabbix-agent

# Habilita serviços
systemctl enable mariadb
systemctl enable apache2
systemctl enable zabbix-server
systemctl enable zabbix-agent

echo "================================================="
echo " ZABBIX INSTALADO COM SUCESSO"
echo " URL: http://$(hostname -I | awk '{print $1}')/zabbix"
echo " Banco: zabbix"
echo " Usuário: zabbix"
echo " Senha: zabbix123"
echo "================================================="