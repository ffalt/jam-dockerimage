#!/bin/bash
echo "Starting App"
cd /home/node/jam/serve/ || exit
node --experimental-modules --es-module-specifier-resolution=node /home/node/jam/serve/dist/index.js
