#~/.bash_profile
# System loads
# -------------
# if running bash
# Get the aliases and functions
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# Load the .profile, good if you are on ubuntu
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi
# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set PATH so it includes usr/local/bin/
if [ -d "/usr/local/bin" ]; then
    PATH="$PATH:/usr/local/bin"
fi

# SSH
# ----
# Startigng ssh agent and adding the id_rsa
eval $(ssh-agent) >/dev/null

# Load ssh key but if failing i need to know
if [ -f "$HOME/.ssh/id_rsa" ]; then
    ssh-add ~/.ssh/id_rsa 1>/dev/null
fi

if [ -f "$HOME/.ssh/id_rsa_kris9854" ]; then
    ssh-add ~/.ssh/id_rsa_kris9854 1>/dev/null
fi

if [ -f "id_rsa_kekomplexit" ]; then
    ssh-add ~/.ssh/id_rsa_kekomplexit 1>/dev/null
fi

# Terminal Improvements
# ---------------------
# Setup
# Source bash_profile
alias resource='source ~/.bash_profile'
# List files
alias ll='ls -alhZ'
# List files (reverse)
alias llr='ls -alhr'
# List files by size
alias lls='ls -alhS'

alias llsr='ls -alhSr'
# List files by date
alias lld='ls -alht'
# List files by date (reverse)
alias lldr='ls -alhtr'
# List files by date created
alias lldc='ls -alhtU'
# List files by date created (reverse)
alias lldcr='ls -alhtUr'
# List the file structure of the current directory
alias ctree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# NETWORKING
# -----------
# myip: Public facing IP Address
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
# netCons: Show all open TCP/IP sockets
alias netCons='lsof -i'
# flushDNS: Flush out the DNS Cache
alias flushDNS='dscacheutil -flushcache'
# lsock: Display open sockets
alias lsock='sudo /usr/sbin/lsof -i -P'

# Require confirmation before overwriting target files. This setting keeps me from deleting things I didn't expect to, etc
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'




# Functions
# -----------
# Git fast track alias
# Function to add, commit, and push changes to a Git repository
# Usage: cgitadd "commit message"
#
# Args:
#     commit message (str): The commit message describing the changes.
#
# Returns:
#     None
function cgitadd() {
    git add .
    git commit -m "$1"
    git push
}

#  extract:  Extract most know archives with one command
extract() {
    if [ -f $1 ]; then
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
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

data_usage() {
    du -sh --exclude='/proc/*' --exclude='/tmp/*' --exclude='/var/*' /* 2>/dev/null | sort -hr
}
# Set the terminal colors
# -----------------------
# Check if the hostname starts with "prod-"
# https://robotmoon.com/bash-prompt-generator/
# https://ezprompt.net/
# Check if the hostname starts with "prod-"
if [[ "$HOSTNAME" == prod-* ]]; then
    # If the user is root, set the PS1 prompt with red username and yellow hostname
    if [[ "$USER" == "root" ]]; then
        export PS1="\[$(tput setaf 9)\]\u\[$(tput setaf 9)\]@\[$(tput setaf 9)\]\h\[$(tput setaf 7)\]:\w\[$(tput sgr0)\]$ "
    else
        # If the user is not root, set the PS1 prompt with default username and yellow hostname
        export PS1="\[$(tput setaf 15)\]\u\[$(tput setaf 9)\]@\[$(tput setaf 9)\]\h\[
$(tput setaf 15)\]:\w\[$(tput sgr0)\]$ "
    fi
fi
# Oh by post for bash
eval "$(oh-my-posh init bash)"
source ~/.config/oh-my-posh/.posh_init_bash.sh
source ~/.config/oh-my-posh/.posh_completion_bash.sh
