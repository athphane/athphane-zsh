# Athphane ZSH Plugin Documentation

This is a comprehensive ZSH plugin designed for PHP/Laravel developers with a local development environment. The plugin provides numerous aliases, functions, and utilities to streamline development workflows.

## Overview

The plugin is organized into modular components, each focusing on specific technologies or tasks:

- Main plugin loader: `athphane-zsh.plugin.zsh`
- Helper functions: `helpers.zsh`
- Quick aliases: `quick-aliases.zsh`
- Technology-specific modules: `php.zsh`, `laravel.zsh`, `docker.zsh`, etc.

## Core Features

### Dynamic PHP Version Switching
Automatically detects the required PHP version from your project's `composer.json` and uses the appropriate PHP executable.

### Laravel Development Tools
Streamlined commands for common Laravel development tasks including:
- Artisan command shortcuts
- Database management
- Environment configuration
- Testing utilities

### Local Development Environment Management
Tools for managing local development with:
- Nginx configuration generation
- MySQL database creation
- Docker Compose utilities
- Hosts file management

## Module Breakdown

### Helpers (`helpers.zsh`)
Provides utility functions used throughout the plugin:

- `cecho` - Colored text output for better CLI experience
- `reload` - Reload ZSH configuration
- `open-in-browser` - Open URLs in preferred browser

### Quick Aliases (`quick-aliases.zsh`)
Convenient shortcuts for common tasks:

- Directory navigation aliases (`home`, `www`, `athphane-zsh`)
- Editor configuration (`nano` as default)
- Common typo corrections (`clar`, `realc` for `clear`)

### PHP (`php.zsh`)
Dynamic PHP version management:

- `dynamicPhpVersionSwitcher` - Automatically uses the PHP version specified in `composer.json`
- `composerWithProjectPhpVersion` - Runs Composer with the project's PHP version
- Aliases: `php`, `composer`

### Laravel (`laravel.zsh`)
Laravel-specific utilities:

- Artisan shortcuts (`art`, `tinker`, `arl`)
- Testing tools (`test`, `pint`, `pest`, `paratest`)
- Log monitoring (`laravel-logs`, `logs`, `pail`)
- Database utilities (`amfs`)
- Project creation (`laravel-new`)
- Site opening (`open-site`)
- Environment configuration (`configure_laravel_env_db`)

### Laravel Nginx (`laravel-nginx.zsh`)
Automated Nginx configuration for Laravel projects:

- `nginx-create` - One-command setup for Laravel projects with Nginx
- `get_php_version` - Extracts PHP version from `composer.json`
- `create_nginx_config` - Generates Nginx server blocks
- `append-host` - Manages `/etc/hosts` entries

### MySQL (`mysql.zsh`)
Database management utilities:

- `create_mysql_db` - Creates MySQL databases with automatic sanitization

### Docker (`docker.zsh`)
Docker Compose utilities:

- `dockerComposeStackControl` - Standardized Docker Compose commands
- `dc-stack` - Alias for Docker Compose stack control

### Hastebin (`hastebin.zsh`)
CLI interface for Hastebin:

- `haste` - Upload content to Hastebin service
- Configurable server endpoint

### Git (`git.zsh`)
Git workflow enhancements:

- Basic aliases (`pull`, `push`)
- Tag management (`bump_tag`)

### Node (`node.zsh`)
Node.js/NPM utilities:

- Build/dev aliases (`nrb`, `nrd`)
- Legacy Node support (`node-old`)

### Other Modules
- `composer.zsh` - Composer-specific utilities
- `dropbox.zsh` - Dropbox integration
- `javaabu.zsh` - Custom utilities
- `other-app-aliases.zsh` - Additional application aliases
- `python.zsh` - Python development utilities

## Installation & Usage

1. Clone the repository to your Oh My Zsh custom plugins directory
2. Add `athphane-zsh` to your plugins list in `.zshrc`
3. Restart your terminal or run `source ~/.zshrc`

## Requirements

- Oh My Zsh
- PHP versions installed locally (for PHP version switching)
- Nginx (for Laravel Nginx features)
- MySQL/MariaDB (for database creation features)
- Docker (for Docker Compose utilities)
- jq (for JSON parsing in PHP version detection)

## Customization

The plugin is designed to be modular - you can comment out specific modules in `athphane-zsh.plugin.zsh` if you don't need certain functionality.