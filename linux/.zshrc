## Errors
if ! command -v fzf &>/dev/null; then
  echo "⚠️  fzf is not installed. zsh-interactive-cd may not work properly."
fi

# Export variables
# ----------------
# Set the default editor to vim
export EDITOR=vim

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

# Load custom configurations and secrets
# --------------------------------------
[ -f "$HOME/.config/zsh/shell_functions.sh" ] && source "$HOME/.config/zsh/shell_functions.sh"
[ -f "$HOME/.config/zsh/exports.sh" ] && source "$HOME/.config/zsh/exports.sh"
[ -f "$HOME/.config/zsh/.secrets.sh" ] && source "$HOME/.config/zsh/.secrets.sh"
[ -f "$HOME/.config/zsh/.secrets.sh" ] && source "$HOME/.config/private-dotfiles/private_zsh/.secrets.sh"
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
zstyle ':completion:*' menu no
zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History settings
# ----------------
HISTSIZE=5000
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
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Define SSH keys
SSH_KEYS=(
  #"id_rsa"
  #"id_bitbucket"
  #"id_ed25519_linux_key_a-sosdakew"
  #"id_rsa_ssh_access"
  #"id_rsa_hyperv"
  #"id_rsa_ebdruplab_kris9854"
  #"id_wsl_home"
)

# SSH Configuration
# -----------------
# Starting ssh-agent and adding the keys
eval $(ssh-agent) >/dev/null
for key in "${SSH_KEYS[@]}"; do
  key_path="$HOME/.ssh/$key"
  [ -f "$key_path" ] && /bin/ssh-add "$key_path" >/dev/null
done

