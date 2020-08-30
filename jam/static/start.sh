#!/bin/bash

if [ -n "$DATABASE_CHECK" ]
then
  while ! wget -q -O - "$DATABASE_CHECK"; do sleep 10; done;
fi

echo "Starting App"
cd /home/node
pm2 start processes.json
pm2 logs
