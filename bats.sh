#!/bin/bash

source system.sh

bats::install(){

  if ! system::check_command bats; then
    echo "Failed to find command bats. Installing bats'"
    git clone https://github.com/sstephenson/bats.git
    cd bats
    ./install.sh /usr/local
  fi

}
