#!/bin/bash
set -e

# Keep $SSH_AUTH_SOCK environment variable in sudo
file=/etc/sudoers.d/env_keep_ssh_auth_sock
echo "Defaults    env_keep += \"SSH_AUTH_SOCK\"" | sudo tee "$file" > /dev/null
sudo chown root:root "$file"
sudo chmod 0440 "$file"

# Give all users access to ssh agent socket
if [ ! -z "$SSH_AUTH_SOCK" ]
then
  sudo chmod a+x $(dirname $SSH_AUTH_SOCK)
  sudo chmod a+rw $SSH_AUTH_SOCK
fi
