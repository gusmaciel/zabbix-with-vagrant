# Zabbix 7.4 com Vagrant, Debian 12 e MariaDB

Este projeto automatiza a criação de um ambiente de monitoramento utilizando **Zabbix 7.4**, **MariaDB** e **Apache2** em uma máquina virtual **Debian 12 (Bookworm)** provisionada com **Vagrant** e **VirtualBox**.

## Tecnologias Utilizadas

* Vagrant
* VirtualBox
* Debian 12 (Bookworm)
* MariaDB
* Apache2
* PHP
* Zabbix Server 7.4
* Zabbix Agent

## Requisitos

Antes de iniciar, certifique-se de possuir:

* Vagrant instalado
* VirtualBox instalado
* Conexão com a internet para download dos pacotes

## Configuração da Máquina Virtual

| Configuração        | Valor                |
| ------------------- | -------------------- |
| Sistema Operacional | Debian 12 (Bookworm) |
| Hostname            | zabbix               |
| Nome da VM          | ZABBIX               |
| Memória RAM         | 2048 MB              |
| CPUs                | 2                    |
| IP Privado          | 192.168.56.10        |

## Como Utilizar

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/zabbix-vagrant.git
cd zabbix-vagrant
```

### 2. Inicializar a máquina virtual

```bash
vagrant up
```

O provisionamento pode levar alguns minutos, pois serão realizados downloads e instalações automáticas.

### 3. Acessar a máquina virtual

```bash
vagrant ssh
```

## Componentes Instalados

Durante o provisionamento são instalados e configurados automaticamente:

* MariaDB Server
* Apache2
* Zabbix Server
* Zabbix Frontend
* Zabbix Agent
* Scripts SQL do Zabbix

## Banco de Dados

O script cria automaticamente:

**Banco de Dados**

```sql
zabbix
```

**Usuário**

```text
zabbix
```

**Senha**

```text
zabbix
```

## Acesso ao Zabbix

Após a conclusão da instalação, acesse:

```text
http://192.168.56.10/zabbix
```

### Credenciais padrão do Zabbix

| Usuário | Senha  |
| ------- | ------ |
| Admin   | zabbix |

> Recomenda-se alterar a senha padrão após o primeiro acesso.

## Serviços Configurados

Os seguintes serviços são iniciados e habilitados automaticamente:

* zabbix-server
* zabbix-agent
* apache2
* mariadb

## Verificação dos Serviços

Para verificar o status dos serviços:

```bash
sudo systemctl status zabbix-server
sudo systemctl status zabbix-agent
sudo systemctl status apache2
sudo systemctl status mariadb
```

## Destruir o Ambiente

Caso deseje remover a máquina virtual:

```bash
vagrant destroy -f
```

## Estrutura do Projeto

```text
.
├── Vagrantfile
└── README.md
```

## Observações

* Este ambiente é destinado para estudos, laboratórios e demonstrações.
* As credenciais do banco de dados estão definidas diretamente no script de provisionamento.
* Não é recomendado utilizar esta configuração em produção sem ajustes de segurança.

## Licença

Este projeto é disponibilizado para fins educacionais e de laboratório.