# ------------------------------------------------------------
# Dynamic PHP / Composer version switcher for Zsh
# ------------------------------------------------------------

# Default PHP executable to use when no composer.json PHP version is found
DEFAULT_PROJECT_PHP="php83"

# Default Composer executable
COMPOSER_EXECUTABLE="/usr/local/bin/composer"


# Resolve PHP executable from composer.json
resolveProjectPhpExecutable() {
    local php_constraint
    local php_version
    local php_executable

    # No composer.json, use default PHP
    if [[ ! -f composer.json ]]; then
        echo "$DEFAULT_PROJECT_PHP"
        return 0
    fi

    # Make sure jq exists
    if ! command -v jq >/dev/null 2>&1; then
        cecho yellow "jq not found. Using default PHP version." >&2
        echo "$DEFAULT_PROJECT_PHP"
        return 0
    fi

    # Get PHP constraint from composer.json
    php_constraint=$(jq -r '.require.php // empty' composer.json 2>/dev/null)

    # No PHP constraint, use default PHP
    if [[ -z "$php_constraint" ]]; then
        echo "$DEFAULT_PROJECT_PHP"
        return 0
    fi

    # Extract first PHP-looking version.
    #
    # Examples:
    # "8.4.*"       -> 84
    # "^8.4"        -> 84
    # "~8.4"        -> 84
    # ">=8.4"       -> 84
    # ">=8.3 <8.5"  -> 83
    # "^8.3|^8.4"   -> 83
    php_version=$(
        echo "$php_constraint" \
            | grep -oE '[0-9]+\.[0-9]+' \
            | head -n1 \
            | tr -d '.'
    )

    # Could not parse version, use default PHP
    if [[ -z "$php_version" ]]; then
        cecho yellow "Could not resolve PHP version from composer.json constraint '$php_constraint'. Using default PHP version." >&2
        echo "$DEFAULT_PROJECT_PHP"
        return 0
    fi

    php_executable="/usr/bin/php$php_version"

    # Use resolved PHP if it exists
    if [[ -x "$php_executable" ]]; then
        echo "$php_executable"
        return 0
    fi

    # Fallback
    cecho yellow "PHP executable $php_executable not found. Using default PHP version." >&2
    echo "$DEFAULT_PROJECT_PHP"
}


# Run PHP using the version required by the current project's composer.json
dynamicPhpVersionSwitcher() {
    local php_executable

    php_executable=$(resolveProjectPhpExecutable)

    if [[ "$php_executable" == "$DEFAULT_PROJECT_PHP" ]]; then
        cecho blue "Using default PHP version..."
    else
        cecho blue "Switching to $php_executable for this project..."
    fi

    "$php_executable" "$@"
}


# Run Composer using the PHP version required by the current project's composer.json
composerWithProjectPhpVersion() {
    local php_executable
    local composer_executable="$COMPOSER_EXECUTABLE"

    # Prefer the configured Composer path
    if [[ ! -x "$composer_executable" ]]; then
        # Fallback: find real composer binary from PATH.
        # `whence -p` is Zsh-safe and avoids aliases/functions.
        composer_executable=$(whence -p composer 2>/dev/null)
    fi

    if [[ -z "$composer_executable" || ! -x "$composer_executable" ]]; then
        cecho red "Composer not found. Please make sure it is installed and in your PATH."
        return 1
    fi

    php_executable=$(resolveProjectPhpExecutable)

    if [[ "$php_executable" == "$DEFAULT_PROJECT_PHP" ]]; then
        cecho blue "Using default PHP version for Composer..."
    else
        cecho blue "Running Composer with $php_executable..."
    fi

    "$php_executable" "$composer_executable" "$@"
}


# ------------------------------------------------------------
# Aliases
# ------------------------------------------------------------

alias php='dynamicPhpVersionSwitcher'
alias composer='composerWithProjectPhpVersion'