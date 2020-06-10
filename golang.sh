#!/bin/bash
#

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__DIR}/system.sh

GO_VERSION=1.10.2

golang::install(){
  system::get_os
  system::get_machine

  local file="go${GO_VERSION}.${os}-${machine}.tar.gz"
  wget https://dl.google.com/go/${file}
  sudo tar -C /usr/local -xzf ${file}
}

golang::govendor::install(){
  go get -u github.com/kardianos/govendor
}

golang::gocode:install(){
  go get -u github.com/mdempsky/gocode
}
