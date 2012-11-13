# Usage: _api 
_api()
{
    local url
    local token
    local method
    local params

    method="${1}"
    url="https://api.github.com${2}"
    token=$(_get token)
    case ${method} in
        GET)
            params="-G"
        ;;
        POST)
            params="-d"
        ;;
        *)
            _echo "Method ${method} not supported yet."
        ;;
    esac

    if [ ! -z ${token} ]; then
        params="${params} -H 'Authorization: token ${token}'"
    fi

    # -d '{"title": "Implement OAuth", "body":"With curl, you should implement the GitHub API OAuth Workflow"}' \

    eval $(echo curl ${params} "${url}")
}