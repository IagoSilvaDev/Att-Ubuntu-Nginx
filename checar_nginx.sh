#!/bin/bash

# Obter data e hora atuais
DATA_HORA=$(date '+%Y-%m-%d %H:%M:%S')

# Nome do serviço a ser monitorado
SERVICO="nginx"

# Mensagens personalizadas para cada estado
ONLINE_MSG="O serviço de Web-server do Nginx está Online no momento"
OFFLINE_MSG="O serviço de Web-server do Nginx está Offline no momento"

# Verificar o status do serviço
STATUS=$(systemctl is-active $SERVICO)

# Diretórios para armazenar os logs
NGINX_LOG_DIR="/var/log/nginx"
PROJETO_DIR="/home/escreva-o-diretório-do-usuário/Att-Ubuntu-Nginx"
LOG_DIR="$PROJETO_DIR/logs"

# Arquivos de log
NGINX_ONLINE_LOG="$NGINX_LOG_DIR/nginx_status_online.log"
NGINX_OFFLINE_LOG="$NGINX_LOG_DIR/nginx_status_offline.log"
PROJETO_ONLINE_LOG="$LOG_DIR/nginx_status_online.log"
PROJETO_OFFLINE_LOG="$LOG_DIR/nginx_status_offline.log"

# Criar o diretório de logs no projeto, caso não exista
mkdir -p "$LOG_DIR"

# Checar se o serviço está ativo
if [ "$STATUS" == "active" ]; then
    # Serviço online: salva nos dois arquivos de log ONLINE com mensagem personalizada
    echo "$DATA_HORA - $SERVICO - ONLINE - $ONLINE_MSG" | sudo tee -a "$NGINX_ONLINE_LOG" >> "$PROJETO_ONLINE_LOG"
else
    # Serviço offline: salva nos dois arquivos de log OFFLINE com mensagem personalizada
    echo "$DATA_HORA - $SERVICO - OFFLINE - $OFFLINE_MSG" | sudo tee -a "$NGINX_OFFLINE_LOG" >> "$PROJETO_OFFLINE_LOG"
fi



