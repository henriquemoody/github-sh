_command_auth()
{
    local username=$(_get -r username)
    local json=$(
        curl \
            -u "${username}" \
            -d "{\"scopes\":[\"repo\"],\"note\":\"${SCRIPT_TITLE} - $(hostname -s)\"}" \
            https://api.github.com/authorizations
    )
    local code=$(echo "${json}" | _json_parse "auth" | grep auth_token)

    if [ -z "${code}" ]; then
        _command_auth
        return $?
    fi

    eval "${code}"
    _set token "${auth_token}"
}