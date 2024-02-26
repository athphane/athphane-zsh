function wip {
    git stage .
    git add .
    git commit -m "WIP"
    git push
}

# 
function gitCloneHelper {
    if [ "$#" -eq  "0" ]
    then
        cecho red "Please provide a repo name"
    else
        case $1 in 
            *)
            git clone git@github.com:$1.git
            ;;
        esac
    fi
}

# Main function alias
alias gc=gitCloneHelper