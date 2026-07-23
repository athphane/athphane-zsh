#!/bin/bash

# Get the PHP version from composer.json in current directory
get_php_version() {
    if [ -f "composer.json" ]; then
        jq -r '.require.php' composer.json 2>/dev/null | tr -d '^.'
    fi
}

get_php_executable() {
    local php_version
    php_version=$(get_php_version)

    if [ -n "$php_version" ]; then
        local php_executable="/usr/bin/php$php_version"
        if [ -x "$php_executable" ]; then
            echo "$php_executable"
            return 0
        fi
    fi

    echo "/usr/bin/php83"
    return 0
}

php_executable=$(get_php_executable)

if [ "$1" = "--wrapper-info" ]; then
    echo "PHP wrapper - routing to: $php_executable"
    exit 0
fi

exec "$php_executable" "$@"
