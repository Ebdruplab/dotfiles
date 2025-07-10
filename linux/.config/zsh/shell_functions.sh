# Terminal Improvements
# ---------------------
# Enable old app alias
# --------------------
alias neofetch='fastfetch'
alias vim='nvim'
alias vi='nvim'

# Directory navigation aliases
# ----------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias -- -='cd -'
alias cd_ebd='cd ~/git/ebdruplab'

# Terminal control aliases
# ------------------------
alias c='clear'

# Miscellaneous aliases
# ---------------------
alias psg='ps aux | grep -v grep | grep -i'
alias df='df -h'
alias du='du -h -c'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias toupper="tr '[:lower:]' '[:upper:]'"
alias tolower="tr '[:upper:]' '[:lower:]'"

# TMUX Aliases
# -------------
alias tmux="tmux -f ~/.config/tmux/tmux.conf"
alias tmux_ebdruplab='bash -c "$HOME/.config/scripts/tmux_session/ebdruplab_tmux.sh"'
alias tmux_work='bash -c "$HOME/.config/scripts/tmux_session/work_tmux.sh"'


# GIT Aliases
# ------------------
alias gco='git checkout'
alias gaa='git add --all'
alias gcmsg='git commit --message'
alias gcam='git commit --all --message'
alias gfp='git fetch --prune'

# Reload configuration alias
# --------------------------
alias resource='if [ "$SHELL" = "/bin/bash" ]; then source ~/.bash_profile; elif [ "$SHELL" = "/bin/zsh" ]; then source $HOME/.zshrc; fi'

# ls and fzf command aliases
# ------------------
alias ll='ls -alhZ'
# eza! https://the.eza.website/
if hash eza 2>/dev/null; then
  alias ls='eza'                                                          # ls
  alias l='eza -lbF --git'                                                # list, size, type, git
  alias ll='eza -lbGF --git'                                             # long list
  alias llm='eza -lbGd --git --sort=modified'                            # long list, modified date sort
  alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
  alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
  # specialty views
  alias lS='eza -1'                                                              # one column, just names
  alias lt='eza --tree --level=2'                                         # tree
else
    alias llr='ls -alhr'
    alias lls='ls -alhS'
    alias llsr='ls -alhSr'
    alias lld='ls -alht'
    alias lldr='ls -alhtr'
    alias lldc='ls -alhtU'
    alias lldcr='ls -alhtUr'
fi
alias ctree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"


# Create a preview command!
# https://remysharp.com/2018/08/23/cli-improved#fzf--ctrlr
if hash fzf 2>/dev/null; then
    if hash bat 2>/dev/null; then
        alias preview="fzf --preview 'bat --color \"always\" {}'"
    else
        alias preview="fzf --preview 'cat {}'"
    fi
fi
# JSON prettifier alias
# ---------------------
alias json='python -m json.tool'

# SSH aliases
# -----------
alias pssh='ssh -l "$($SSH_USER)" -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Tools aliases
# --------------
alias ebd_list_crontab='for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l; done'

# Enable color support for ls and add handy aliases
# -------------------------------------------------
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
fi

# Add `less` alias with color support
# -----------------------------------
alias less='less -R'

# Networking aliases
# ------------------
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias netCons='lsof -i'
alias flushDNS='dscacheutil -flushcache'
alias lsock='sudo /usr/sbin/lsof -i -P'

# Fabric Aliases
# --------------
if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then
    . "$HOME/.config/fabric/fabric-bootstrap.inc"
fi

# Require confirmation before overwriting target files
# ----------------------------------------------------
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Windows-specific alias
# ----------------------
if grep -q microsoft /proc/version; then
    alias explorer="explorer.exe ."
    alias vs='code .'
fi

# Functions
# ---------

# Function to extract various types of compressed files
function extract() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        printf "Usage: extract <file>\n"
        printf "Extract various types of compressed files.\n"
        printf "Supported file types:\n"
        printf "  *.tar.bz2\n"
        printf "  *.tar.gz\n"
        printf "  *.bz2\n"
        printf "  *.rar\n"
        printf "  *.gz\n"
        printf "  *.tar\n"
        printf "  *.tbz2\n"
        printf "  *.tgz\n"
        printf "  *.zip\n"
        printf "  *.Z\n"
        printf "  *.7z\n"
        printf "  *.ztd\n"
        return
    fi

    if [[ -f $1 ]]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *.ztd) tar --use-compress-program=unzstd -xvf $1 ;;
        *) printf "'%s' cannot be extracted via extract()\n" "$1" ;;
        esac
    else
        printf "'%s' is not a valid file\n" "$1"
    fi
}

# Function to display data usage
function data_usage() {
    du -sh --exclude='/proc/*' --exclude='/tmp/*' --exclude='/var/*' /* 2>/dev/null | sort -hr
}

# Function to connect via SSH with password authentication
function pssh() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        printf "Usage: pssh [user] <host>\n"
        printf "Connect via SSH with password authentication.\n"
        printf "Options:\n"
        printf "  user    Optional. Username to connect with. Default is 'root'.\n"
        printf "  host    Required. Host to connect to.\n"
        return
    fi

    local user="${1:-root}"
    shift
    ssh -l "$user" -o PreferredAuthentications=password -o PubkeyAuthentication=no "$@"
}

# Function to connect via SSH using a specified SSH key
function jssh() {
    if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then
        printf "Usage: jssh [host]\n"
        printf "Connect to a target host via a jump server using a safe AD-style username.\n\n"
        printf "Env vars:\n"
        printf "  CUSTOM_SSH_USER           Username (e.g. a-sosdakew)\n"
        printf "  CUSTOM_SSH_USER_DOMAIN    Domain (e.g. sos.eu)\n"
        printf "  CUSTOM_SSH_JUMPIDENTITY   Identity file for jump host\n"
        printf "  CUSTOM_SSH_JUMPSRV        Jump host address\n"
        return 1
    fi

    local target_host="$1"
    local user="${CUSTOM_SSH_USER}"
    local domain="${CUSTOM_SSH_USER_DOMAIN}"
    local identityfile="$CUSTOM_SSH_JUMPIDENTITY"
    local jumpsrv="$CUSTOM_SSH_JUMPSRV"

    # Combine domain and user with a safe separator (dash)
    local fulluser="${domain}@${user}"

    echo ssh -J "'${fulluser}'@${jumpsrv}" -i "$identityfile" "'${fulluser}'@${target_host}"
}

# Function to connect via SSH using a specified SSH key
function issh() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        printf "Usage: issh [user] <host>\n"
        printf "Connect via SSH using a specified SSH key.\n"
        printf "Options:\n"
        printf "  user    Optional. Username to connect with. Default is 'root'.\n"
        printf "  host    Required. Host to connect to.\n"
        return
    fi

    local user="${1:-root}"
    shift
    ssh -l "$user" -i ~/.ssh/id_rsa_ssh_access "$@"
}

# Function to check if a process is running
function check_process() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        printf "Usage: check_process <process_name>\n"
        printf "Check if a process is running.\n"
        printf "Options:\n"
        printf "  process_name   Required. The name of the process to check.\n"
        return
    fi

    local process_name="$1"

    if [[ -z "$process_name" ]]; then
        printf "Error: Process name must be specified.\n" >&2
        return 1
    fi

    if pgrep "$process_name" >/dev/null; then
        printf "Process '%s' is running.\n" "$process_name"
    else
        printf "Process '%s' is not running.\n" "$process_name"
    fi
}

# Function to convert Markdown to PDF
function md2pdf() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        printf "Usage: md2pdf <input_file> <output_file>\n"
        printf "Convert a Markdown file to PDF using pandoc.\n"
        printf "Options:\n"
        printf "  input_file   Required. The Markdown file to convert.\n"
        printf "  output_file  Required. The name of the output PDF file.\n"
        return
    fi

    local input_file="$1"
    local output_file="$2"

    if [[ -z "$input_file" || -z "$output_file" ]]; then
        printf "Error: Both input and output files must be specified.\n" >&2
        return 1
    fi

    if [[ ! -f "$input_file" ]]; then
        printf "Error: Input file '%s' does not exist.\n" "$input_file" >&2
        return 1
    fi

    pandoc "$input_file" -o "$output_file"

    if [[ $? -eq 0 ]]; then
        printf "PDF created successfully: %s\n" "$output_file"
    else
        printf "Error creating PDF.\n" >&2
        return 1
    fi
}

# Function to show the top 10 largest files in a directory
function largest_files() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        printf "Usage: largest_files <directory>\n"
        printf "Show the top 10 largest files in a directory.\n"
        printf "Options:\n"
        printf "  directory   Required. The directory to search.\n"
        return
    fi

    local directory="$1"

    if [[ -z "$directory" ]]; then
        printf "Error: Directory must be specified.\n" >&2
        return 1
    fi
}

# ebd_sp: search-and-replace across files, with per-file confirmation
#
# Usage: ebd_sp <from> <to>
#
ebd_sp() {
  # 1) Ensure exactly two args were passed
  if (( $# != 2 )); then
    echo "Usage: ebd_sp <from> <to>"
    return 1
  fi

  local from=$1             # the string to search for
  local to=$2               # the string to replace it with
  local files=() file ans   # array & loop vars
  local sed_args            # will hold our sed “-i” flags

  # 2) Detect GNU vs BSD/macOS sed in-place syntax
  if sed --version &>/dev/null; then
    # GNU sed
    sed_args=(-i)
  else
    # BSD/macOS sed
    sed_args=(-i '')
  fi

  # 3) Build an array of all matching filenames:
  #    - grep -RIl: recursive, ignore binaries, list filenames only
  #    - readarray/mapfile splits on newlines into the 'files' array
  if ! files=( ); then :; fi  # ensure array exists even if grep fails
  readarray -t files < <(grep -RIl -- "$from" .)

  # 4) If no files found, nothing to do
  if (( ${#files[@]} == 0 )); then
    echo "No occurrences of '$from' found."
    return 0
  fi

  # 5) Loop over each file, show context, and prompt
  for file in "${files[@]}"; do
    echo
    echo "===== $file ====="
    # 5a) Show 3 lines BEFORE each match, with line numbers
    grep -n -B3 -- "$from" "$file"
    echo
    # 5b) Prompt the user (y/N)
    printf "Replace all '%s' → '%s' in %s? [y/N] " "$from" "$to" "$file"
    read -r ans

    # 5c) On “y” or “Y”, perform the in-place replacement
    if [[ $ans =~ ^[Yy]$ ]]; then
      sed "${sed_args[@]}" "s|$from|$to|g" "$file"
      echo "  ✓ updated $file"
    else
      echo "  – skipped $file"
    fi
  done

  echo
  echo "All done."
}

# If yazi is installed, define 'y' to run it and auto-cd into its --cwd result
if command -v yazi &>/dev/null; then
  y() {
    # create a temp file to capture yazi's desired cwd
    local tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || {
      echo "Failed to create temp file" >&2
      return 1
    }

    # run yazi, passing through all args and telling it to write cwd to $tmp
    yazi "$@" --cwd-file="$tmp"
    local cwd

    # read the entire temp-file into $cwd (handles spaces/newlines)
    # -r: raw; -d '' reads until NUL (EOF)
    IFS= read -r -d '' cwd < "$tmp" || true

    # if $cwd non-empty and differs from current dir, cd into it
    if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
      builtin cd -- "$cwd"
    fi

    # clean up
    rm -f -- "$tmp"
  }
fi

