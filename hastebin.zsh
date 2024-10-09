export HASTEBIN_SERVER="https://paste.athfan.dev"

function haste() {
    curl -X POST -s -d "$(cat)" $HASTEBIN_SERVER/documents --header "content-type: text/plain" | jq --raw-output '.key' | { read key; echo "$HASTEBIN_SERVER/${key}"; }
}   