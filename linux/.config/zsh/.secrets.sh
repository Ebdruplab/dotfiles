# EXPORTS
# -------
export SAT_USERNAME="${USERNAME}"
export SAT_PASSWORD="pass"
export AUTOMATIONHUB_API_KEY="null"
export AUTOMATIONHUB_SERVER="https://automationhub.ebdruplab.dk/api/galaxy/content/staging/"
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
