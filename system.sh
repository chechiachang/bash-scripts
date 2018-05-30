#!/bin/bash
# System
# Supported os:
#   Ubuntu
#   Darwin

system::get_os(){
  os_info=$(uname -o)
  if [[ ${os_info} = *Linux* ]]; then
    os="linux"
  elif [[ ${os_info} = *Darwin* ]]; then
    os="darwin"
  fi
  export os=${os}
}

system::get_machine(){
  machine_info=$(uname -m)
  if [[ ${machine_info} = *x86_64* ]]; then
    machine="amd64"
  elif [[ ${machine_info} = *i386* ]]; then
    machine="i386"
  fi
  export machine=${machine}
}
