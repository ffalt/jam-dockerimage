#!/bin/bash
echo "Starting App"
cd /home/node || exit
pm2 start processes.json
pm2 logs
