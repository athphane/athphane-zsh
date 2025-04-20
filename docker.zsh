# Setting environment variable so that it can be used.
DOCKERDIR="$HOME/docker"

# Main function itself
function dockerComposeStackControl {
    if [ "$#" -eq  "0" ]
    then
        cecho red "Please provide a stack name."
    else
        case $1 in 
            *)
            cecho green "Attempting default initializer..."
            docker compose -p "$1" --env-file $DOCKERDIR/compose-files/.env -f $DOCKERDIR/compose-files/$1.yml "${@:2}"
            ;;
        esac
    fi
}

# Main function alias
alias dc-stack=dockerComposeStackControl
