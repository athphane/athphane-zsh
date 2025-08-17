![athphane-zsh](https://socialify.git.ci/athphane/athphane-zsh/image?language=1&name=1&owner=1&stargazers=1&theme=Light)
---

# Athphane ZSH Plugin

A personal ZSH plugin with custom scripts and utilities designed to enhance my development environment and CLI experience, particularly for PHP/Laravel development.

## Introduction

This ZSH plugin is a collection of carefully crafted tools, aliases, and functions that I've developed to streamline my own development workflow. It's specifically tailored to my personal setup and preferences as a PHP/Laravel developer working on Arch Linux with multiple locally installed PHP versions.

While this repository is very much curated for my personal use, I'm sharing it in the hope that other developers might find value in some of the utilities or be inspired to create their own personalized development environments.

Unlike many modern development workflows, I don't use Docker containers for PHP development. I never quite understood how to use it efficiently for local development, so I have Nginx and multiple PHP versions installed locally. However, I do run my MySQL server inside a container, mapped to a local port, which is why you'll see some Docker-related utilities in the plugin.

The plugin helps me work more efficiently with:
- Multiple PHP versions managed locally through AUR
- Laravel application development
- Local Nginx configurations
- MySQL running in a container
- Common CLI operations and workflows

## Features

### PHP & Composer
- **Dynamic PHP Version Switching**: Automatically detects and uses the PHP version specified in your project's `composer.json`
- **Composer Integration**: Runs Composer with the correct PHP version for your project

### Laravel Development
- **Artisan Shortcuts**: Quick access to common Artisan commands
- **Testing Tools**: Simplified access to PHPUnit, Pest, Paratest, and Laravel Pint
- **Environment Management**: Automatic `.env` configuration for new projects
- **Log Monitoring**: Real-time Laravel log tailing

### Local Development Environment
- **Nginx Configuration**: One-command setup for Nginx server blocks with correct PHP version
- **Database Creation**: Automatic MySQL database creation based on project name (connects to containerized MySQL)
- **Hosts File Management**: Automated `/etc/hosts` entry management
- **Docker Compose Utilities**: Standardized Docker Compose operations (primarily for MySQL container)

### CLI Enhancements
- **Hastebin Integration**: CLI command for quick code/text pasting
- **Colored Output**: Enhanced terminal feedback with color-coded messages
- **Browser Integration**: Open URLs in your preferred browser from the command line
- **Navigation Shortcuts**: Quick directory navigation aliases

### Development Utilities
- **Git Workflow**: Enhanced Git operations and tag management
- **Node.js Tools**: NPM script aliases and legacy Node support
- **System Utilities**: Custom functions for common system operations

## Installation

1. Clone this repository to your Oh My Zsh custom plugins directory:
   ```bash
   git clone https://github.com/athphane/athphane-zsh.git ~/.oh-my-zsh/custom/plugins/athphane-zsh
   ```

2. Add the plugin to your `.zshrc` file:
   ```bash
   plugins=(... athphane-zsh)
   ```

3. Restart your terminal or reload your ZSH configuration:
   ```bash
   source ~/.zshrc
   ```

## Requirements

- [Oh My Zsh](https://ohmyz.sh/)
- PHP versions installed locally (for PHP version switching)
- Nginx (for Laravel Nginx features)
- MySQL/MariaDB (running in a container, mapped to local port)
- Docker (only for MySQL container)
- [jq](https://stedolan.github.io/jq/) (for JSON parsing in PHP version detection)

## Customization

The plugin is designed with modularity in mind. If you don't need certain functionality, you can comment out specific modules in `athphane-zsh.plugin.zsh`.

Each feature is contained in its own `.zsh` file, making it easy to:
- Add new functionality
- Modify existing features
- Remove unused components

## Documentation

For detailed information about each module and its functions, see the [QWEN.md](.qwen/QWEN.md) documentation file.

## Contributing

While this is primarily a personal plugin, I welcome any feedback, suggestions, or contributions that could help improve it or make it more useful for others.

## License

This project is open source and available under the [MIT License](LICENSE).