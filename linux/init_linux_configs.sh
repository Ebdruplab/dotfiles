#!/bin/bash

# Base URL for the dotfiles repository
BASE_URL="https://raw.githubusercontent.com/Ebdruplab/dotfiles/main/linux"

# List of files to download
declare -a files=(".bash_profile" ".vimrc" ".vim/colors/smyck.vim" ".config/.ansible_variables.sh" "")

# Function to download each file
download_file() {
    local file=$1
    local url="${BASE_URL}/${file}"
    local target="$HOME/${file}"

    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # Download the file
    echo "Downloading ${file}..."
    curl -fsSL "$url" -o "$target"
}

# Download each file in the list
for file in "${files[@]}"; do
    download_file "$file"
done

echo "All files downloaded successfully."