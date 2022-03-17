#!/bin/bash

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
mkdir -p ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build ~/.rbenv/plugins/ruby-build

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
