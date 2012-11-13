# _command_issue_list [ REPOSITORY ]
_command_issue_list()
{
    local repository="${1}"
    local url="https://api.github.com/repos"
    if [ -z "${repository}" ]; then
        if [ -z "${GITHUB_REPOSITORY}" ]; then
            read -e -p "Project name: " repository
        else
            repository="${GITHUB_REPOSITORY}"
        fi
    fi

    url="${url}/${repository}/issues"

    if [ "${GITHUB_USERNAME}" != "" ]; then
        extra_param="${GITHUB_USERNAME}"
        if [ "${GITHUB_TOKEN}" != "" ]; then
            extra_param="${extra_param}:${GITHUB_TOKEN}"
        fi
        extra_param="-u '${extra_param}'"
    fi

    echo ${url}
    JSON_CONTENT=$(curl "${extra_param}" -L "${url}" 2>/dev/null)

    echo "${JSON_CONTENT}" \
      | awk '/title/ {print NR}' \
      | while read title_line; do
          let number_line=(title_line+9)
          title=$(echo "${JSON_CONTENT}" | _jsonline ${title_line})
          number=$(echo "${JSON_CONTENT}" | _jsonline ${number_line})
          echo "${number}. ${title}"
        done
}
