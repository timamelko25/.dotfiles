#!/bin/bash

# Install Zsh and dependencies
echo "[1/6] Installing zsh and dependencies..."
sudo pacman -S --noconfirm zsh zsh-completions git curl

# Install Oh My Zsh (if not already installed)
echo "[2/6] Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed, skipping..."
fi

# Install plugins
echo "[3/6] Installing plugins..."
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Configure .zshrc
echo "[4/6] Creating .zshrc configuration..."
cat > ~/.zshrc << 'EOL'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}
)
%{$fg[white]%}%n%{$reset_color%}@%{$fg[white]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)
$(prompt_char) '

RPROMPT=''

# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Using custom theme "dst"
ZSH_THEME="dst"

# Plugins
plugins=(git zsh-syntax-highlighting docker kubectl zsh-autosuggestions)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Wayland settings
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland

# SSH Agent
eval `ssh-agent -s` > /dev/null

. "$HOME/.local/bin/env"

alias k='kubectl'
FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit
EOL

# Change default shell to zsh
echo "[5/6] Changing default shell to zsh..."
chsh -s $(which zsh)

# Installation complete
echo "[6/6] Installation complete! To apply changes:"
echo "1. Close current terminal"
echo "2. Open new terminal"
echo "3. Run: exec zsh"
