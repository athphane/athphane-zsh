# Function to switch PHP version on the fly based on what PHP version the project uses.
dynamicPhpVersionSwitcher() {
    local composer_php_version
    composer_php_version=$(jq -r '.require.php' composer.json 2>/dev/null | tr -d '^.')

    if [ -n "$composer_php_version" ]; then
        local php_executable="/usr/bin/php$composer_php_version"
        if [ -x "$php_executable" ]; then
            cecho blue "Switching to PHP $composer_php_version for this project..."
            $php_executable "$@"
        else
            cecho yellow "PHP $composer_php_version executable not found. Using default PHP version."
            php83 "$@"
        fi
    else
        cecho blue "No specific PHP version found in composer.json. Using default PHP version."
        php83 "$@"
    fi
}

# Function to switch Composer version based on composer.json
composerWithProjectPhpVersion() {
    # Check if composer is installed
    if ! command -v composer &>/dev/null; then
        cecho red "Composer not found. Please make sure it is installed and in your PATH."
        return 1
    fi

    # Get the path to the Composer executable from the system
    local composer_executable
    composer_executable=/usr/local/bin/composer

    # Get the PHP version from the project's composer.json file
    local composer_php_version
    composer_php_version=$(jq -r '.require.php' composer.json 2>/dev/null | tr -d '^.')

    # If a PHP version was found from the composer.json file
    if [ -n "$composer_php_version" ]; then

        # Make the full path to the PHP executable
        local php_executable="/usr/bin/php$composer_php_version"
        if [ -x "$php_executable" ]; then
            cecho blue "Switching to PHP $composer_php_version for this project..."
            $php_executable $composer_executable "$@"
        else
            cecho yellow "PHP $composer_php_version executable not found. Using default PHP version."
            php83 $composer_executable "$@"
        fi
    else
        cecho blue "No specific PHP version found in composer.json. Using default PHP version."
        php83 $composer_executable "$@"
    fi
}


alias php=dynamicPhpVersionSwitcher
alias composer=composerWithProjectPhpVersion