# File: .bash_profile
#~/.bash_profile
# System loads
# -------------
# if running bash
# Source .bashrc and .profile if they exist
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.config/.bash_public" ] && . "$HOME/.bash_public"
[ -f "$HOME/.config/.bash_private" ] && . "$HOME/.bash_private"

# Variables
# ---------
# List of directories to potentially add to PATH
directories=("$HOME/bin" "$HOME/.local/bin" "/usr/local/bin" "$HOME/git/ebdruplab/ansible-shared/scripts")

# Define a list of your SSH keys
SSH_KEYS=("id_rsa_example1" "access_example" "idexample")

# Initialize an array to hold the additional paths
additional_paths=()

# Loop through each directory and add it to the array if it exists
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        additional_paths+=("$dir")
    fi
done

# Add the additional paths to the PATH environment variable
for path in "${additional_paths[@]}"; do
    PATH="$PATH:$path"
done

# Export the updated PATH
export PATH

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

# SSH
# ----

# Startigng ssh agent and adding the id_rsa
eval $(ssh-agent) >/dev/null

# Loop through each key and add it if it exists
for key in "${SSH_KEYS[@]}"; do
    key_path="$HOME/.ssh/$key"
    if [ -f "$key_path" ]; then
        ssh-add "$key_path" 1>/dev/null
    fi
done
