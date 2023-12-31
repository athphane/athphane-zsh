# Basic
alias art="php artisan"
alias tinker="php artisan tinker"

# Database
alias amfs="php artisan migrate:fresh --seed"

# Routes
function artisanRouteList {
    php artisan route:list --sort=name $@
}

alias arl=artisanRouteList