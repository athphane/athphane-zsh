# Colored text echoing
cecho() {
  local code="\033["
  case "$1" in
    black  | bk) color="${code}0;30m";;
    red    |  r) color="${code}0;31m";;
    green  |  g) color="${code}0;32m";;
    yellow |  y) color="${code}0;33m";;
    blue   |  b) color="${code}0;34m";;
    purple |  p) color="${code}0;35m";;
    cyan   |  c) color="${code}0;36m";;
    gray   | gr) color="${code}0;37m";;
    *) local text="$1"
  esac
  [ -z "$text" ] && local text="${color}$2${code}0m"
  echo -e "$text"
}


# Clearing terminal cause I'm stoopid
alias clar=clear