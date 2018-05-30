#!/bin/bash
#

# Dependencies
#   system.sh

GO_VERSION=1.10.2

golang::install(){
  system::get_os
  system::get_machine

  local file="go${GO_VERSION}.${os}-${machine}.tar.gz"
  wget https://dl.google.com/go/${file}
  sudo tar -C /usr/local -xzf ${file}
}

golang::govendor(){
  go get -u github.com/kardianos/govendor
}
