#!/bin/bash

set -eu

export USERNAME=$1
export HOME_DIR="/home/$USERNAME"

su -c "$(pwd)/root.sh" root

su -c "$(pwd)/user.sh" $USERNAME

