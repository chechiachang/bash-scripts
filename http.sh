#!/bin/bash

httpie::install(){

  if hash http 2>/dev/null; then
    echo "Using aws-cli $(which http)"
  else
    echo "Failed to find command aws. Install with 'sudo apt install httpie'"
    exit 1
  fi

}

httpie::get(){
  declare url=$1
  http -v --check-status ${url}
}

httpie::post(){
  declare url=$1 boby_file=$2 
  http -v --check-status ${url} < ${body_file}
}
