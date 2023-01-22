#!/bin/bash

SCREEN_NAME="flamenco-worker"
DATE=$(date)

if ! screen -list | grep -q $SCREEN_NAME; then
  echo "$DATE - $HOSTNAME - $SCREEN_NAME terminated" >> $HOME/Rendering/init/reconcile.log 2>&1
  $HOME/Rendering/init/worker.sh
fi