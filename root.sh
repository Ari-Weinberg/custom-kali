#!/bin/bash

echo "in root.sh: $(whoami)"
env
echo "------------"

# Add vscode repo
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

# Install Docker repo:
LATEST_DEBIAN_RELEASE=$(curl -s https://www.debian.org/releases/stable/ | grep -E '<title>Debian -- Debian &ldquo;(\w*)&rdquo; Release Information <\/title>' | sed -E 's/<title>Debian -- Debian &ldquo;(\w*)&rdquo; Release Information <\/title>/\1/')
printf '%s\n' "deb https://download.docker.com/linux/debian $LATEST_DEBIAN_RELEASE stable" | tee /etc/apt/sources.list.d/docker-ce.list
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-ce-archive-keyring.gpg

# Install ngrok
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list

# Packages
apt update
apt-get install -qq -y libxft-dev libxinerama-dev libfreetype6-dev libfontconfig1-dev picom feh acpi rofi \
    libimlib2-dev dex apt-transport-https code docker-ce docker-ce-cli containerd.io \
    terminator seclists curl dnsrecon enum4linux feroxbuster \
    gobuster impacket-scripts nbtscan nikto nmap onesixtyone oscanner \
    redis-tools smbclient smbmap snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev zsh burpsuite ngrok

cd /tmp

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install GO
wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
 rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.3.linux-amd64.tar.gz

# Install jetbrains mono
mkdir jetbrains
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d jetbrains
cd jetbrains
mv *.ttf /usr/share/fonts/
fc-cache -fv

# Add user to docker group
usermod -aG docker $USERNAME