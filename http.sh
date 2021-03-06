#!/bin/bash

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__DIR}/system.sh

httpie::install(){

  system::check_command http

}

httpie::get(){
  declare url=$1
  http -v --check-status ${url}
}

httpie::post(){
  declare url=$1; shift
  declare boby_file=$*
  echo ${body_file} http -v --check-status ${url}
}
