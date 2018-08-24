#!/bin/bash

source system.sh

httpie::install(){

  system::check_command http

}

httpie::get(){
  declare url=$1
  http -v --check-status ${url}
}

httpie::post(){
  declare url=$1 boby_file=$2 
  http -v --check-status ${url} < ${body_file}
}
