# Function to get cleaned PHP version from composer.json
get_php_version() {
    local php_version=$(jq -r '.require.php' composer.json 2>/dev/null | tr -d '^.')
    echo $php_version
}


# Function to create nginx server block
create_nginx_config() {
    local php_sock_path="/var/run/php$2-fpm/php-fpm.sock"

    cat > "/etc/nginx/sites-available/$3" <<EOL
server {
    listen 80;
    server_name admin.$3.test $3.test;

    root $1/public;
    index index.php index.html index.htm;

    charset utf-8;

    client_max_body_size 50M;   

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_pass unix:$php_sock_path;
        fastcgi_index index.php;
        include fastcgi_params;
    }

    # gzip
    gzip            on;
    gzip_vary       on;
    gzip_proxied    any;
    gzip_comp_level 6;
    gzip_types      text/plain text/css text/xml application/json application/javascript application/rss+xml application/atom+xml image/svg+xml;

    # Deny basics
    location ~ /\.ht { deny all; }

    # Logging
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/$3-error.log error;
}
EOL
}

append-host() {
    # Check if the correct number of arguments is provided
    if [ "$#" -ne 1 ]; then
        cecho red "Usage: $0 <domain>"
        return 1
    fi

    # Input domain to be added
    domain="$1"

    # File path of the hosts file
    hosts_file="/etc/hosts"  # Update this path as needed

    # Check if the file exists
    if [ ! -f "$hosts_file" ]; then
        cecho red "Error: Hosts file not found at $hosts_file"
        return 1
    fi

    # Directory to store backups
    backup_dir="$HOME/.hosts_backups"
    mkdir -p "$backup_dir"

    # Backup the hosts file with a timestamp
    backup_file="$backup_dir/hosts_$(date +'%Y%m%d_%H%M%S').bak"
    sudo cp "$hosts_file" "$backup_file"


    # Define the path to the hosts file
    hosts_file="/etc/hosts"

    # Define the markers for the section
    start_marker="#START-nginx"
    end_marker="#END-nginx"

    # Check if the section markers exist at the bottom of the file
    if grep -q "$start_marker" "$hosts_file" && grep -q "$end_marker" "$hosts_file"; then
        # Check if the host entry already exists within the section
        if ! grep -q "127.0.0.1 $domain" "$hosts_file"; then
            # Append the new host to the existing section
            sudo awk -v start="$start_marker" -v end="$end_marker" -v domain="$domain" '
                $0 ~ end && !found_end { found_end = 1; print "127.0.0.1 " domain; } 1
            ' "$hosts_file" > "/tmp/hosts.tmp" && sudo mv "/tmp/hosts.tmp" "$hosts_file"
        fi
    else
        # If the markers don't exist, add them and then add the new host
        echo "$start_marker" >> "$hosts_file"
        echo "127.0.0.1 $domain" >> "$hosts_file"
        echo "$end_marker" >> "$hosts_file"
    fi


    echo "Domain $domain added successfully to the hosts file."
}

nginx-create() {
    local current_directory=$PWD
    local php_version=$(get_php_version)    
    local base_name=$(basename $current_directory)

    cecho blue "Full Directory: $current_directory"
    cecho blue "Base Name: $base_name"

    if zsudo create_nginx_config $current_directory $php_version $base_name; then
        cecho green "$base_name NGINX configuration created!"
    else
        cecho red "something went wrong"
        return 1
    fi

    if sudo ln -s /etc/nginx/sites-available/$base_name /etc/nginx/sites-enabled; then
        cecho green "$base_name NGINX configuration linked!"
    else
        return 1
    fi

    if sudo nginx -t > /dev/null 2>&1; then
        cecho green "NGINX configuration test successful"
        sudo systemctl reload nginx
        zsudo append-host "$base_name.test" > /dev/null 2>&1
        zsudo append-host "admin.$base_name.test" > /dev/null 2>&1
    else
        cecho rd "NGINX configuration test failed. Removing created files."
        rm /etc/nginx/sites-enabled/$base_name
        rm /etc/nginx/sites-available/$base_name
        return 1
    fi

    cecho green "Creating database for $base_name"
    create_mysql_db "$base_name"

    cecho green "Creating environment from example"
    cp $current_directory/.env.example $current_directory/.env

    cecho green "Updating environment database connection to local machine configuration"
    configure_laravel_env_db "$current_directory/.env" "$base_name"
}
