# Exports not secret
# defaul exports
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_DK.UTF-8"
export LC_ALL="en_DK.UTF-8"
# Ansible
export ANSIBLE_TIMEOUT='200'

# non secret
export SSH_USER="${USERNAME}"
# Fabric Exports
# ---------------
# Need ollama remote or local - https://www.ollama.com/
# Need fabric - https://github.com/danielmiessler/fabric
if command -v fabric &>/dev/null; then
    export OPENAI_API_KEY="NULL"
    export DEFAULT_MODEL="phi3:mini"
    export OPENAI_BASE_URL=http://localhost:11434/api
fi
