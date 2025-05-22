# Git
alias pull="git pull"
alias push="git push"

bump_tag() {
  local cur_tag version parts major minor patch bump_type new_tag
  cur_tag=$(git describe --tags --abbrev=0 2>/dev/null) || { echo "No tags found."; return 1; }
  echo "Current tag: $cur_tag"

  PS3="Select bump type (1=bug, 2=minor, 3=major): "
  select bump_type in bug minor major; do
    [[ -n $bump_type ]] && break
    echo "Invalid choice."
  done

  version=${cur_tag#v}
  parts=("${(@s/./)version}")
  major=$parts[1] minor=$parts[2] patch=$parts[3]

  case $bump_type in
    bug)   patch=$((patch+1)) ;;
    minor) minor=$((minor+1)); patch=0 ;;
    major) major=$((major+1)); minor=0; patch=0 ;;
  esac

  new_tag="v${major}.${minor}.${patch}"
  echo "Creating tag $new_tag"
  git tag "$new_tag"
}