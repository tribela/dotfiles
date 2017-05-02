#!/bin/bash
set -e

sudo bash < <(curl -sL https://deb.nodesource.com/setup_6.x)
sudo apt install nodejs

npm install -g add-local-binaries-to-path
