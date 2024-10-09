# Node/NPM Aliases  
alias nrb="npm run build"
alias nrd="npm run dev"

# Fallback function for old node projects that complain about something
# I forget what the something is now.
function node-old {
    export NODE_OPTIONS=--openssl-legacy-provider
}
