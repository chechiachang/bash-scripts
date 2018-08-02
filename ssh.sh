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

# ssh_tunnel::enable on local server create a systemd service unit which maintain a ssh reverse tunnel to remote tunnel server, enable ssh connection from remote tunnel server.
# Usage: ssh::tunnel::enable [tunnel_server_ip] [ssh_key_path]
# Example: ssh::tunnel::enable user@13.14.15.16 ${HOME}/.ssh/id_rsa
ssh::tunnel::enable(){

  declare tunnel_server_ssh=$1 ssh_key=$2 

cat >autossh.service <<EOL
[Unit]
Description=Keeps a tunnel to linker networks open
After=network.target

[Service]
User=autossh
ExecStart=/usr/bin/autossh -M 0 -N -q -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -p 22 -l autossh ${tunnel_server_ssh} -L 17474:127.0.0.1:17474 -i ${ssh_key}
ExecStop=killall -s KILL autossh
RestartSec=5

[Install]
WantedBy=multi-user.target
EOL

  sudo mv autossh.service /etc/systemd/system/
  sudo systemctl enable autossh.service

}
