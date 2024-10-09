function bonsai {
    command_to_check="cbonsai"

    if command -v $command_to_check &> /dev/null; then
        if [[ -n $1 ]]; then
            cbonsai -l -L 50 -m "$1"
        else
            cbonsai -l -L 50
        fi
    else
        cecho red "$command_to_check does not exist"
        cecho blue "Download the cbonsai-git package form the AUR first."
        cecho blue "https://aur.archlinux.org/packages/cbonsai-git"
    fi
}    