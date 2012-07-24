# set VAR [ VALUE ]
github_external_set()
{
    if [ -z "${1}" ]
    then
        for key in "${!SCRIPT_VARS[@]}"; do
            value="${SCRIPT_VARS[${key}]}";
            if [ ${key} == "password" ]
            then
                value=$(echo "${value}" | tr '[:print:]' '*')
            fi
            echo "${key}: ${value}"
        done
        return 0
    fi

    github_internal_set "${1}" "${2}" \
        && echo "Value of \"${1}\" defined with sucess."
}