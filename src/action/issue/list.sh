# _action_issue_list [ PROJECT ]
_action_issue_list()
{
    local project="${1}"
    local url="https://api.github.com/repos"
    if [ -z "${project}" ]; then
        if [ -z "${GITHUB_PROJECT}" ]; then
            read -e -p "Project name: " project
        else
            project="${GITHUB_PROJECT}"
        fi
    fi

    url="${url}/${project}/issues"

    if [ "${GITHUB_USERNAME}" != "" ]; then
        extra_param="${GITHUB_USERNAME}"
        if [ "${GITHUB_PASSWORD}" != "" ]; then
            extra_param="${extra_param}:${GITHUB_PASSWORD}"
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
