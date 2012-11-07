_github_fetch()
{    
    local url="https://api.github.com${1}"
    local params="-L"

    if [ "${GITHUB_USERNAME}" != "" ]; then
        auth="${GITHUB_USERNAME}"
        if [ "${GITHUB_PASSWORD}" != "" ]; then
            auth="${auth}:${GITHUB_PASSWORD}"
        fi
        params="${params} -u '${auth}'"
    fi

    echo curl ${params} "${url}" 2>/dev/null
    return $?
}

