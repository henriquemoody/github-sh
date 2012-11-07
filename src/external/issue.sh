# _external_issue ACTION NUMBER [ PROJECT [ USER ] ]
_external_issue()
{
    if [ -z "${1}" ]; then
        _echo "You should define a issue action. (See \"help\" for more information)" 31 1>&2
        return 2
    fi

    if [ -z "${2}" ]; then
        _echo "You should define a issue number. (See \"help\" for more information)" 31 1>&2
        return 3
    fi

    local action="${1}"
    local number="${2}"
    local project="${3}"
    local user="${4}"
    local extra_param=""
    local url

    if [ -z "${project}" ]; then
        if [ -z "${GITHUB_PROJECT}" ]; then
            read -e -p "Project name: " project
        else
            project="${GITHUB_PROJECT}"
        fi
    fi

    if [ -z "${user}" ]; then
        if [ -z "${GITHUB_USERNAME}" ]; then
            read -e -p "User or Organization: " project
        else
            user="${GITHUB_USERNAME}"
        fi
    fi

    url="https://api.github.com/repos/${user}/${project}/issues/${number}/comments"

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
