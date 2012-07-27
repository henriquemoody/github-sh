# github_external_issue NUMBER [ PROJECT [ USER ] ]
github_external_issue()
{
    if [ -z "${1}" ]
    then
        echo "You should define a issue number. (See \"help\" for more information)" 
        return 2
    fi

    local number="${1}"
    local project="${2}"
    local user="${3}"
    local url

    if [ -z "${project}" ]
    then
        if [ -z ${SCRIPT_VARS["project"]} ]
        then
            github_external_set project
        fi
        project="${SCRIPT_VARS["project"]}"
    fi

    if [ -z "${user}" ]
    then
        if [ -z ${SCRIPT_VARS["user"]} ]
        then
            github_external_set user
        fi
        user="${SCRIPT_VARS["user"]}"
    fi

    url="https://api.github.com/repos/${user}/${project}/issues/${number}/comments"
    echo $url
    curl -L "${url}" | grep "body" | cut -d "\"" -f 4 | while read line 
    do
        echo "${line}"
        echo
    done

}