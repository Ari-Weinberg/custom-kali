#!/bin/bash

echo "in user.sh: $(whoami)"
env
echo "------------"

cd $HOME_DIR

# Install OMZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
zsh -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
zsh -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME_DIR/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' $HOME_DIR/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' $HOME_DIR/.zshrc
chsh -s $(which zsh) $USERNAME

mkdir $HOME_DIR/.config/terminator/
curl -s https://raw.githubusercontent.com/Ari-Weinberg/kali-init-setup/main/terminator_config -o $HOME_DIR/.config/terminator/config

# Install pyenv (https://github.com/pyenv/pyenv)
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME_DIR/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME_DIR/.zshrc
echo 'eval "$(pyenv init -)"' >> $HOME_DIR/.zshrc

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> $HOME_DIR/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME_DIR/.zshrc
# nvm install node