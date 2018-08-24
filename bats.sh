#!/bin/bash

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__DIR}/system.sh

bats::install(){

  if ! system::check_command bats; then
    echo "Failed to find command bats. Installing bats'"
    git clone https://github.com/sstephenson/bats.git
    cd bats
    ./install.sh /usr/local
  fi

}
