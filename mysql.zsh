function create_mysql_db {
    local input_db_name="$1"
    local db_name="${input_db_name//[-]/_}"  # Replace hyphens with underscores

    # Check if the database name is provided
    if [ -z "$db_name" ]; then
        cecho yellow "Usage: create_mysql_db <database_name>"
        return 1
    fi

    # Create MySQL database
    # Using mariadb cause my system kept yelling at me about it
    cecho yellow "Enter MySQL password"
    mariadb --defaults-file=~/.my.cnf -h 127.0.0.1 -u root -p -e "CREATE DATABASE IF NOT EXISTS $db_name;"
    
    result=$?

    if [ $result -eq 0 ]; then
        cecho green "MySQL database '$db_name' created successfully."
    else
        cecho red "Error creating MySQL database."
    fi
}