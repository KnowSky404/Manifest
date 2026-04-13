export EDITOR=vim
export LANG=en_US.UTF-8

alias ll='ls -lah'
alias gs='git status'

setProxy() {
    local host="${1:-127.0.0.1}"
    local port="${2:-9929}"
    local proxy_url="http://${host}:${port}"
    local socks_url="socks5://${host}:${port}"

    export http_proxy="${proxy_url}"
    export https_proxy="${proxy_url}"
    export HTTP_PROXY="${proxy_url}"
    export HTTPS_PROXY="${proxy_url}"
    export all_proxy="${socks_url}"
    export ALL_PROXY="${socks_url}"

    echo "Proxy enabled:"
    echo "  http_proxy=${http_proxy}"
    echo "  https_proxy=${https_proxy}"
    echo "  all_proxy=${all_proxy}"
}

unsetProxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset all_proxy
    unset ALL_PROXY

    echo "Proxy disabled."
}

setRemoteProxy() {
    setProxy "${1:-127.0.0.1}" "${2:-9929}"
}

setLocalProxy() {
    setProxy "${1:-127.0.0.1}" "${2:-7890}"
}
