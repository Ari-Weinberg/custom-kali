#!/bin/bash

set -eu

export USERNAME=$1
export HOME_DIR="/home/$USERNAME"
export REPO_DIR=$(pwd)

# Allow kali user to use sudo without password:
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" | EDITOR='tee -a' visudo

su -c "./root.sh" 

su -c "./user.sh" $(pwd)

