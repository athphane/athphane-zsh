# Basic
alias art="php artisan"
alias tinker="php artisan tinker"
alias test="php ./vendor/bin/phpunit"
alias pint="php ./vendor/bin/pint"

# Database
alias amfs="php artisan migrate:fresh --seed"

# Routes
function artisanRouteList {
    php artisan route:list --sort=name $@
}

alias arl=artisanRouteList

function open-site {
    local current_directory=$PWD
    local base_name=$(basename $current_directory)
    local home_www="$HOME/www"

    # Check if the current directory is inside $HOME/www
    if [[ $current_directory == $home_www* ]]; then
        firefox "$base_name.test"
    else
        echo "Error: Current directory is not inside $home_www"
    fi
}