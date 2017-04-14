#!/bin/bash

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm

curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
git clone https://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict
