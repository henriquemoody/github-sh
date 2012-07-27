# github_external_issue ACTION NUMBER [ PROJECT [ USER ] ]
github_external_issue()
{
    if [ -z "${1}" ]
    then
        github_internal_echo "You should define a issue action. (See \"help\" for more information)" 31 1>&2
        return 2
    fi

    if [ -z "${2}" ]
    then
        github_internal_echo "You should define a issue number. (See \"help\" for more information)" 31 1>&2
        return 3
    fi

    local action="${1}"
    local number="${2}"
    local project="${3}"
    local user="${4}"
    local extra_param=""
    local url

    if [ -z "${project}" ]
    then
        if [ -z "${SCRIPT_VAR_PROJ}" ]
        then
            read -e -p "Project name: " project
        else
            project="${SCRIPT_VAR_PROJ}"
        fi
    fi

    if [ -z "${user}" ]
    then
        if [ -z "${SCRIPT_VAR_USER}" ]
        then
            read -e -p "User or Organization: " project
        else
            user="${SCRIPT_VAR_USER}"
        fi
    fi

    url="https://api.github.com/repos/${user}/${project}/issues/${number}/comments"

    if [ "${SCRIPT_VAR_USER}" != "" ]
    then
        extra_param="${SCRIPT_VAR_USER}"
        if [ "${SCRIPT_VAR_PASS}" != "" ]
        then
            extra_param="${extra_param}:${SCRIPT_VAR_PASS}"
        fi
        extra_param="-u '${extra_param}'"
    fi

    curl "${extra_param}" -L "${url}" | grep "body" | cut -d "\"" -f 4 | while read line 
    do
        echo "${line}"
        echo
    done

}