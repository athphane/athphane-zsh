# Basic
alias art="php artisan"
alias tinker="php artisan tinker"
alias test="php ./vendor/bin/phpunit"
alias pint="php ./vendor/bin/pint --parallel"
alias pest="php ./vendor/bin/pest"
alias paratest="php ./vendor/bin/paratest"
alias laravel-logs="tail -f storage/logs/laravel.log"
alias logs="laravel-logs"
alias pail="php artisan pail"

# Database
alias amfs="php artisan migrate:fresh --seed"

# Create new Laravel Project
function laravel-new {
    composer create-project laravel/laravel $@
}

# Routes
function artisanRouteList {
    php artisan route:list --sort=name $@
}

# Run Laravel Pint in docker container
function laravel-pint {
  docker run -it --rm -v $(pwd):/code --workdir=/code composer:latest php /code/vendor/bin/pint --parallel --ansi
}

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

function configure_laravel_env_db() {
  # Check if both arguments are provided
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: ./update_env.sh <path_to_env_file> <database_name>"
    return 1
  fi

  # Store the provided .env file path and database name
  local env_file=$1
  local input_db_name=$2
  local db_name="${input_db_name//[-]/_}"  # Replace hyphens with underscores

  # Check if the specified .env file exists
  if [[ ! -f $env_file ]]; then
    echo "$env_file not found."
    return 1
  fi

  # Update the .env file using sed
  sed -i '' \
    -e 's/^DB_CONNECTION=sqlite/DB_CONNECTION=mysql/' \
    -e 's/^# DB_USERNAME=root/DB_USERNAME=root/' \
    -e 's/^# DB_HOST=127.0.0.1/DB_HOST=127.0.0.1/' \
    -e 's/^# DB_PORT=3306/DB_PORT=3306/' \
    -e 's/^# DB_DATABASE=laravel/DB_DATABASE='"$db_name"'/'     \
    -e 's/^# DB_PASSWORD=/DB_PASSWORD=password/' "$env_file"

  echo "$env_file updated successfully."
}

alias arl=artisanRouteList
