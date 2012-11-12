# _command_issue ACTION NUMBER [ REPOSITORY [ USER ] ]
_command_issue()
{
    if [ -z "${1}" ]; then
        _echo '[31]You should define a issue action. (See "help list" for more information)'
        return 2
    fi

    if [ -z "${2}" ]; then
        _echo '[31]You should define a issue number. (See "help list" for more information)'
        return 3
    fi

    local action="${1}"
    local number="${2}"
    local repository="${3}"
    local user="${4}"
    local extra_param=""
    local url

    if [ -z "${repository}" ]; then
        if [ -z "${GITHUB_REPOSITORY}" ]; then
            read -e -p "Project name: " repository
        else
            repository="${GITHUB_REPOSITORY}"
        fi
    fi

    if [ -z "${user}" ]; then
        if [ -z "${GITHUB_USERNAME}" ]; then
            read -e -p "User or Organization: " repository
        else
            user="${GITHUB_USERNAME}"
        fi
    fi

    url="https://api.github.com/repos/${user}/${repository}/issues/${number}/comments"

    if [ "${GITHUB_USERNAME}" != "" ]; then
        extra_param="${GITHUB_USERNAME}"
        if [ "${GITHUB_PASSWORD}" != "" ]; then
            extra_param="${extra_param}:${GITHUB_PASSWORD}"
        fi
        extra_param="-u '${extra_param}'"
    fi

    curl "${extra_param}" -L "${url}" \
      | grep body \
      | cut -d '"' -f 4- \
      | awk '{ gsub(/\\n/, "\n"); print }' \
      | while read line; do
          echo "${line}"
        done

}
