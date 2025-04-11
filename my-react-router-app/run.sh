#!/bin/bash
echo "start run.sh"
NODE_ENV=production exec ./node_modules/@react-router/serve/bin.js ./build/server/index.js