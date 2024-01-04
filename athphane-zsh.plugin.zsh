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
zsource laravel
zsource laravel-nginx
zsource mysql
zsource athphane
zsource other-app-aliases