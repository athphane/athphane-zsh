function zsource {
  local filename="$ZSH_CUSTOM/plugins/athphane-zsh/$1.zsh"
  if [ -f "$filename" ]; then
    source "$filename"
  else
    echo "Error: File not found or not accessible - $filename"
  fi
}

zsource helpers
zsource quick-aliases
zsource docker
zsource php
zsource composer
zsource laravel
zsource laravel-nginx
zsource javaabu
zsource mysql
zsource athphane
zsource dropbox
zsource other-app-aliases
zsource hastebin
zsource node
zsource python
zsource git
zsource charmbracelet