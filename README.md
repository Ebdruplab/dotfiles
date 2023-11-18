## Download NerdFonts
JetBrainsMono Nerd font from "nerdfonts.com"
- extract archive
- right click install for all users

(starship web)[https://starship.rs/]

## Bash

IF YOU JUST WANT TO USE THE .vimrc, .bash_profile and the .config/.ansible_vars just use this command to auto download all the usefull files.
`wget -qO- https://raw.githubusercontent.com/Ebdruplab/dotfiles/main/linux/init_linux_configs.sh | bash`


Better to use posh than starship


**Linux:**
```bash
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
```

**Windows:**
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
```

### Font installation
oh-my-posh font install # and i download hack

### windows-terminal.json

the `windows-terminal.json` is the settings.json for your windows terminal. 