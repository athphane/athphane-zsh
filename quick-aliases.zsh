# =================
# Exports
# =================
export EDITOR=nano
export WWW="$HOME/www"
export MAKEFLAGS="-j10"    
export ATHPHANE_ZSH="$ZSH_CUSTOM/plugins/athphane-zsh"

# =================
# Directory aliases
# =================
alias home="cd $HOME"
alias www="cd $WWW"
alias athphane-zsh="code $ATHPHANE_ZSH"

# =================
# Shortcuts
# =================
alias php-version=get_php_version
alias clear-clipboard="qdbus org.kde.klipper /klipper org.kde.klipper.klipper.clearClipboardHistory"

# =================
# Spelling Mistakes
# =================

# Clear
alias clar=clear
alias realc=clear


# Git
alias pull="git pull"
alias push="git push"