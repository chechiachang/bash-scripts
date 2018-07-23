#!/bin/bash

# Usage: scp_file [file] username@host
# Example: scp_file myfile username@10.1.0.1:.

scp_file(){
  scp -i ${SSH_KEY_FILE} -o StrictHostKeyChecking=no "$@"
}

# Usage: ssh_cmd username@host [cmd] [arg...]
# Example: ssh_cmd sudo apt-get install -y python

ssh_cmd(){
  ssh -i ${SSH_KEY_FILE} -o StrictHostKeyChecking=no "$@"
}
