# ~/.bash_profile

# Load .bashrc and .profile if they exist
if [ -f "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi
if [ -f "$HOME/.profile" ]; then . "$HOME/.profile"; fi

# Function to add a directory to PATH if it's not already included
add_to_path() {
    [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:${PATH}"
}

# Update PATH with custom directories
add_to_path "$HOME/bin"
add_to_path "$HOME/.local/bin"
add_to_path "/usr/local/bin"

# Aliases
# -------
alias resource='source ~/.bash_profile'
alias ll='ls -alhZ'
alias llr='ls -alhr'
alias lls='ls -alhS'
alias llsr='ls -alhSr'
alias lld='ls -alht'
alias lldr='ls -alhtr'
alias lldc='ls -alhtU'
alias lldcr='ls -alhtUr'
alias ctree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias netCons='lsof -i'
alias flushDNS='dscacheutil -flushcache'
alias lsock='sudo /usr/sbin/lsof -i -P'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias explorer="explorer.exe ."

# Functions
# ---------
cgitadd() {
    git add .
    git commit -m "$1"
    git push
}

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

# Terminal Prompt Customization
# -----------------------------
if [[ "$HOSTNAME" == prod-* ]]; then
    if [[ "$USER" == "root" ]]; then
        export PS1="\[$(tput setaf 9)\]\u@\h:\w\$ "
    else
        export PS1="\[$(tput setaf 15)\]\u@\h:\w\$ "
    fi
fi

# SSH Key Management
# ------------------
eval $(ssh-agent) >/dev/null
ssh-add-key() {
    key="$HOME/.ssh/$1"
    if [ -f "$key" ] && ! ssh-add -l | grep -q "$key"; then
        ssh-add "$key"
    fi
}

ssh-add-key "id_rsa_kris9854"
ssh-add-key "id_rsa_hyperv"

# System Information
# ------------------
sysinfo() {
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "CPU Load:"
    uptime
}

# Add more custom functions, aliases, and environment settings below
# Function to load a file from ~/.config/
load_config_file() {
    local filename="$1"
    local filepath="$HOME/.config/${filename}"

    if [[ -f "$filepath" ]]; then
        echo "Loading $filename..."
        source "$filepath"
    else
        echo "Error: File $filename does not exist in ~/.config/"
    fi
}

# Usage: load_config_file ".ansible_variables"
load_config_file ".ansible_variables"