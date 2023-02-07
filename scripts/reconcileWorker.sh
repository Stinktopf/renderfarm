#!/bin/bash

SCREEN_NAME="flamenco-worker"
DATE=$(date)
MANAGER_URL="<manager_ip>:8080"

# Pruefen auf beendeten Prozess
if ! screen -list | grep -q $SCREEN_NAME; then
  echo "$DATE - $HOSTNAME - $SCREEN_NAME terminated" >> $HOME/Rendering/init/reconcile.log 2>&1
  $HOME/Rendering/init/worker.sh
else

# Senden einer HTTP-Anforderung an die API mit curl
response=$(curl -s $MANAGER_URL/api/v3/worker-mgt/workers)

# Verarbeiten der JSON-Antwort mit jq
STATE=$(echo $response | $HOME/Rendering/init/jq-linux64 '.workers[] | select(.name == "'"$HOSTNAME"'") | .status')

if [[ "$STATE" == "\"error\"" ]]; then
    echo "$DATE - $HOSTNAME - $SCREEN_NAME has an error" >> $HOME/Rendering/init/reconcile.log 2>&1
    screen -X -S flamenco-worker quit
    $HOME/Rendering/init/worker.sh
fi
fi
