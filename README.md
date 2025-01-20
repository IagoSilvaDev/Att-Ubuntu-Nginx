 # Att-Ubuntu-Nginx

Este repositório contém um script para monitorar o status do serviço **Nginx** no Ubuntu a partir do WSL, verificando se o serviço está **online** ou **offline**, e registrando o resultado em arquivos de log.

## Objetivo

- Verificar se o serviço **Nginx** está ativo.
- Registrar a data, hora, status e mensagem personalizada (ONLINE ou OFFLINE) em arquivos de log.
- Gerar dois arquivos de log: um para quando o serviço estiver **online** e outro para quando estiver **offline**.
- Automatizar a execução do script a cada 5 minutos.

## Requisitos

**Instalar o WSL (Windows Subsystem for Linux)**:

   Para configurar o ambiente de execução no Windows, é necessário instalar o **WSL** e o **Ubuntu**:
   
   - Abra o **PowerShell** como administrador e execute o comando abaixo para atualizar o WSL e depois instalar o Ubuntu:
     ```bash
     wsl --update # Atualiza wsl
     ```
     ```bash
     wsl --install -d Ubuntu # Instala a distribuição do linux Ubuntu
     ```
   - Será pedido para você configurar um usuário, configure-o, esse será o usuário em que você devera ajeitar o diretório no script.
   - Após a instalação, reinicie o computador, caso necessário.
   - Para mais detalhes sobre o WSL, consulte o [Tutorial oficial da Microsoft](https://learn.microsoft.com/pt-br/windows/wsl/install).

 **Instalar o Nginx**:

   Após configurar o WSL, abra o terminal do Ubuntu e execute os seguintes comandos para instalar o **Nginx**:
   ```bash
   sudo apt update && sudo apt upgrade # verificando atualizações no sistema
   ```
   ```bash
   sudo apt install nginx -y # instala o nginx
   ```
## Como Usar

1. **Clone o repositório**:

   Antes de clonar o repositório, certifique-se de que o **Git** está instalado. Para verificar, execute o comando:

   ```bash
   git --version # checa a versão do git
   ```
   Se o Git não estiver instalado, você pode instalá-lo com o seguinte comando:
   
   ```bash
   sudo apt install git -y # verifica atualizações e instala o git
   ```
   Depois de fazer esse processo, clone o repositório e entre em deus diretórios:
   ```bash
   git clone https://github.com/IagoSilvaDev/Att-Ubuntu-Nginx.git # Clona o repositório
   ```
   ```bash
   cd Att-Ubuntu-Nginx # Move-se para o diretório do projeto
   ```

2. **Verifique se o Nginx está ativo**:

   Verifique o status do serviço **Nginx** e **cron**:
   ```bash
   sudo systemctl status nginx
   ```
   ```bash
   sudo systemctl status cron
   ```
   Se necessário, inicie o serviço **Nginx** ou **cron**:
   
   ```bash
   sudo systemctl start nginx
   ```
   ```bash
   sudo systemctl start cron
   ```
   
3. **Edite o script para definir o diretório do projeto**:

   Abra o script `checar_nginx.sh` e substitua o caminho do diretório do projeto para o diretório em que você clonou o repositório:
   ```bash
   PROJETO_DIR="/home/usuário/Att-Ubuntu-Nginx"  # Trecho no scrip a ser alterado com o diretório do projeto clonado.
   ```
4. **Copie o script para um diretório padrão**: Para facilitar a execução, copie o script para diretório padrão de scripts do Linux, como `/usr/local/bin`:
   ```bash
   sudo cp checar_nginx.sh /usr/local/bin/ # Copia o script
   ```
   Certifique-se de dar permissões de execução para o script:
   ```bash
   sudo chmod +x /usr/local/bin/checar_nginx.sh # Adiciona a permissão de executar para todos usuários
   ```
5. **Execute o script manualmente com superusuário para teste (root)**:

   Para executar o script manualmente:
   ```bash
   sudo checar_nginx.sh # testa o script
   ```
6. **Automatizando a execução do script a cada 5 minutos**:

   Para rodar o script automaticamente a cada 5 minutos de uma hora(ou seja, ele vai ser executado em minutos múltiplos de 5 como 5,10,15...), edite o crontab com **superusuário (root)**:
   ```bash
   sudo crontab -e # Abre o contrab do superusuário(root)
   ```
   Adicione a seguinte linha para rodar o script a cada 5 minutos:
   ```bash
   */5 * * * * /usr/local/bin/checar_nginx.sh # Trecho a ser inserido no crontab
   ```
   **Observação**: O crontab deve ser configurado com **superusuário (root)** ou um **usuário com permissões adequadas** para acessar o serviço **Nginx** e os diretórios restritos.

7. **Checando os logs**:

   Para checar os os valores dos log basta você executar um comando de leitura em um dos diretórios de gravação dos logs:

   - Para o diretório de logs do nginx:
    ```bash
    cat /var/log/nginx/nginx_status_online.log # Para os registros online
    cat /var/log/nginx/nginx_status_offline.log # Para os registros offline
    ```
    
    - Para o diretório de logs do projeto caso você tenha mantido a mesma estrutura do diretório:
    ```bash
    cat /home/usuário/Att-Ubuntu-Nginx/logs/nginx_status_online.log # Para os registros online
    cat /home/usuário/Att-Ubuntu-Nginx/logs/nginx_status_offline.log # Para os registros offline
    ```

8. **Acessando Nginx**: Para ver o nginx você pode acessar o localhost em algum navegador.

## Estrutura de Diretórios

- **Logs do Nginx**: `/var/log/nginx`
- **Diretório do Projeto**: `/home/usuário/Att-Ubuntu-Nginx/logs`

## Exemplo de Saída

- **Quando o Nginx estiver online**:
   ``
  2025-01-19 12:30:00 - nginx - ONLINE - O serviço de Web-server do Nginx está Online no momento
   ``
- **Quando o Nginx estiver offline**:
   ``
  2025-01-18 12:30:00 - nginx - OFFLINE - O serviço de Web-server do Nginx está Offline no momento
   ``
