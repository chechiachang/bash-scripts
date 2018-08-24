#!/bin/bash
# System
# Supported os:
#   Ubuntu
#   Darwin

system::get_os(){
  os_info=$(uname -a)
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

system::check_command(){
  declare cmd=$1
  if hash ${cmd} 2>/dev/null; then
    echo "Using ${cmd} $(which ${cmd})"
  else
    echo "Failed to find command ${cmd}."
    exit 1
  fi
}
