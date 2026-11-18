#!/bin/bash
echo "Starting App"
cd /home/node/jam/serve/ || exit
exec node /home/node/jam/serve/dist/index.js
