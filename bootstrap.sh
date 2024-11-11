#!/bin/bash

set -eu

export USERNAME=$1
export HOME_DIR="/home/$USERNAME"

# Allow kali user to use sudo without password:
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" | EDITOR='tee -a' visudo

su -c "$(pwd)/root.sh" root

su -c "$(pwd)/user.sh" $USERNAME

