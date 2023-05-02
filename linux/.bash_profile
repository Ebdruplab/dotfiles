#~/.bash_profile
#######
# SSH #
#######
# Startigng ssh agent and adding the id_rsa
eval $(ssh-agent) > /dev/null
# Load ssh key but if failing i need to know
ssh-add ~/.ssh/id_rsa 1> /dev/null
# Terminal Improvements
# Misc Commands
alias resource='source ~/.bash_profile'                                         # Source bash_profile
alias ll='ls -alh'                                                              # List files
alias llr='ls -alhr'                                                            # List files (reverse)
alias lls='ls -alhS'                                                            # List files by size
alias llsr='ls -alhSr'                                                          # List files by size (reverse)
alias lld='ls -alht'                                                            # List files by date
alias lldr='ls -alhtr'                                                          # List files by date (reverse)
alias lldc='ls -alhtU'                                                          # List files by date created
alias lldcr='ls -alhtUr'                                                        # List files by date created (reverse)
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"             # List the file structure of the current directory

###########
# Exports #
###########
export PATH="$PATH:/usr/local/bin/"
export EDITOR=vim
#############
# Functions #
#############
# Chris's improvement of this gist: https://gist.github.com/dergachev/4627207
function mov2gif() {
  width=$(mediainfo $1 | grep Width | tr ' Width:pixels' ' ' | sed 's/ //g') # get the height/width metadata, grep out the spaces and crap
  height=$(mediainfo $1 | grep Height | tr ' Height:pixels' ' ' | sed 's/ //g')
  dimensionString=$width # build a string to pass to the ffmpeg command
  dimensionString+="x"
  dimensionString+=$height
  echo "Dimension determined as:" $dimensionString # notify user of dimensions found
  ffmpeg -i -nostats -loglevel 0 $1 -s $dimensionString -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif # silent mode
  echo "Saved gif as: $1.gif" # saved gif name
}

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

##############
# NETWORKING #
##############
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

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

