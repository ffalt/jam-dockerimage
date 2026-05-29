#!/bin/bash
echo "Starting App"
cd /home/node/jam/serve/ || exit
node /home/node/jam/serve/dist/index.js
