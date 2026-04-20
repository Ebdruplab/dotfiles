# To make it work also install
# https://github.com/jesseduffield/lazygit?tab=readme-ov-file#debian-and-ubuntu
# fzf nvchad prerequists
## Errors
if ! command -v fzf &>/dev/null; then
  echo "⚠️  fzf is not installed. zsh-interactive-cd may not work properly."
fi

# Export variables
# ----------------
# Set the default editor to vim
export EDITOR=vim

# Show completions immediately
setopt AUTO_LIST
unsetopt MENU_COMPLETE

# Disable bell
unsetopt BEEP

# Disable bracketed paste
#unsetopt BRACKETED_PASTE


# Path settings
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/git/ebdruplab/ansible-shared/scripts:/bin:/usr/bin:/snap/bin:$HOME/.cargo/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# zsh theme
#ZSH_THEME="powerlevel10k/powerlevel10k"
# Choose colorize toolkit chroma vs pygments
#ZSH_COLORIZE_TOOL=pygments
#ZSH_COLORIZE_STYLE="colorful"

# .zshrc - Customize your Zsh shell environment
if [ ! -d "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Check and load Oh-My-Posh
# -------------------------
#if command -v oh-my-posh &>/dev/null; then
#  eval "$(oh-my-posh init zsh --config ~/.config/.oh_my_posh.toml)"
#  eval "$(oh-my-posh completion zsh --config ~/.config/.oh_my_posh.toml)"
#else
#  echo "oh-my-posh is not installed"
#fi

# Load fabric-bootstrap if exists
# -------------------------------
[ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ] && . "$HOME/.config/fabric/fabric-bootstrap.inc"


# Plugins
# -------

# oh-my-zsh
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# .zshrc - Customize your Zsh shell environment
if [ ! -d "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Oh My zsh
plugins=(
  #osx
  # helm
  # git
  zsh-interactive-cd
  # ansible
  # web-search
  # podman
  # aliases
  # sudo
  colored-man-pages
  # colorize
)
# Load The plugins
source $ZSH/oh-my-zsh.sh

# Syntax Highlight
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions in terminal
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completion styling (build in zsh)
# ------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History settings
# ----------------
HISTSIZE=10000
SAVEHIST=10000 
HISTFILE=~/.cache/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# History search with arrows
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# Keyboard shortcuts
# -------------------
# Bind Ctrl+Left Arrow to backward-word
bindkey '^[[1;5D' backward-word
# Bind Ctrl+Right Arrow to forward-word
bindkey '^[[1;5C' forward-word
# Bind Ctrl+A to move to the beginning of the line
bindkey '^A' beginning-of-line
# Bind Ctrl+E to move to the end of the line
bindkey '^E' end-of-line
# Bind Ctrl+P to move to the previous command in the history
bindkey '^P' up-line-or-history
# Bind Ctrl+N to move to the next command in the history
bindkey '^N' down-line-or-history

# Dracula Theme Setup
# -------------------
# if [ ! -d "$HOME/.vim/pack/themes/start/dracula" ]; then
#   mkdir -p ~/.vim/pack/themes/start
#   git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
# fi

# Starship setup
# ---------------
# curl -sS https://starship.rs/install.sh | sh
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

eval "$(starship init zsh)"


# SSH Configuration
# -----------------

## This is handling ssh agent on WSL instance so no forwarding
# Define SSH keys
SSH_KEYS=(
  "id_github"
  #"id_rsa"
  #"id_bitbucket"
  #"id_ed25519_linux_key_a-sosdakew"
  #"id_rsa_ssh_access"
  #"id_rsa_hyperv"
  #"id_rsa_ebdruplab_kris9854"
  #"id_wsl_home"
)

# Starting ssh-agent and adding the keys
 eval $(ssh-agent) >/dev/null
 for key in "${SSH_KEYS[@]}"; do
   key_path="$HOME/.ssh/$key"
   [ -f "$key_path" ] && /bin/ssh-add "$key_path" >/dev/null
 done

# Override section for Bitwarden agent forwarding
# ------------------------------------------------
# WSL -> Windows Bitwarden/OpenSSH agent bridge
# WSL -> Windows SSH agent bridge for Bitwarden/OpenSSH
export WIN_USER="${WIN_USER:-$USER}"
export NPIPERELAY_EXE="/mnt/c/Users/${WIN_USER}/AppData/Local/Microsoft/WinGet/Packages/albertony.npiperelay_Microsoft.Winget.Source_8wekyb3d8bbwe/npiperelay.exe"
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"

bw_ssh_agent_start() {
  mkdir -p "$HOME/.ssh"

  # Required tools
  command -v socat >/dev/null 2>&1 || return 0
  [ -x "$NPIPERELAY_EXE" ] || return 0

  # Optional: detect Bitwarden CLI
  if command -v bw >/dev/null 2>&1; then
    export BW_AVAILABLE=1
  else
    export BW_AVAILABLE=0
  fi

  # If socket exists and works, keep it
  if [ -S "$SSH_AUTH_SOCK" ] && ssh-add -L >/dev/null 2>&1; then
    return 0
  fi

  # Clean up stale bridge/socket
  pkill -f "socat.*${SSH_AUTH_SOCK}" >/dev/null 2>&1 || true
  rm -f "$SSH_AUTH_SOCK"

  # Start bridge
  setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"$NPIPERELAY_EXE -ei -s //./pipe/openssh-ssh-agent",nofork >/tmp/socat-ssh-agent.log 2>&1 &
}

bw_ssh_agent_start

# OPEN TUX
# --------
if [ "$(hostname)" = "FedoraWorkstation" ]; then
#  tmux_ebdruplab
fi

# Load custom configurations and secrets
# --------------------------------------
[ -f "$HOME/.config/zsh/shell_functions.sh" ] && source "$HOME/.config/zsh/shell_functions.sh"
[ -f "$HOME/.config/zsh/exports.sh" ] && source "$HOME/.config/zsh/exports.sh"
[ -f "$HOME/.config/zsh/.secrets.sh" ] && source "$HOME/.config/zsh/.secrets.sh"
[ -f "$HOME/.config/zsh/.secrets.sh" ] && source "$HOME/.config/private-dotfiles/private_zsh/.secrets.sh"

clear

