#!/bin/bash

echo "in user.sh: $(whoami)"
env
echo "------------"



cd $HOME

# Install OMZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
zsh -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
zsh -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' $HOME/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' $HOME/.zshrc
# chsh -s $(which zsh) $USERNAME

mkdir $HOME/.config/terminator/
curl -s https://raw.githubusercontent.com/Ari-Weinberg/kali-init-setup/main/terminator_config -o $HOME/.config/terminator/config

# Install pyenv (https://github.com/pyenv/pyenv)
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc
echo 'eval "$(pyenv init -)"' >> $HOME/.zshrc

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.zshrc
source $HOME/.zshrc
nvm install node

# Add GO to path
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.zshrc

# Install pipx and pipx packages
python3 -m pipx ensurepath

pipx install git+https://github.com/Tib3rius/AutoRecon.git
pipx install git+https://github.com/Pennyw0rth/NetExec
pipx install git+https://github.com/ly4k/Certipy.git
pipx install git+https://github.com/Ari-Weinberg/enumerate-iam.git


# cp $REPO_DIR/assets/background.jpg $HOME/Pictures/
# sed -i 's|<property name="last-image" type="string" value="/usr/share/backgrounds/kali-16x9/default"/>|<property name="last-image" type="string" value="'"$HOME"'/background.jpg"/>|g' "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"

startx
xfce4-panel-profiles load $REPO_DIR/configs/xfce4-panel-profiles load
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s $REPO_DIR/assets/background.jpg


