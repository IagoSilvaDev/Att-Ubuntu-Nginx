#!/bin/bash

# Obter data e hora atuais
DATA_HORA=$(date '+%Y-%m-%d %H:%M:%S')

# Nome do serviço a ser monitorado
SERVICO="nginx"

# Verificar o status do serviço
STATUS=$(systemctl is-active $SERVICO)

# Diretórios para armazenar os logs
NGINX_LOG_DIR="/var/log/nginx"
PROJETO_DIR="/home/iago/Att-Ubuntu-Nginx"
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
    # Serviço online: salva nos dois arquivos de log ONLINE
    echo "$DATA_HORA - $SERVICO - ONLINE" | sudo tee -a "$NGINX_ONLINE_LOG" >> "$PROJETO_ONLINE_LOG"
else
    # Serviço offline: salva nos dois arquivos de log OFFLINE
    echo "$DATA_HORA - $SERVICO - OFFLINE" | sudo tee -a "$NGINX_OFFLINE_LOG" >> "$PROJETO_OFFLINE_LOG"
fi


