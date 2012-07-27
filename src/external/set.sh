# github_external_set VAR [ VALUE ]
github_external_set()
{
    if [ -z "${1}" ]
    then
        github_internal_echo "user:      \c" 34
        github_internal_echo "${SCRIPT_VAR_USER}" 32 \
            || github_internal_echo "NULL" 31

        local password=$(echo ${SCRIPT_VAR_PASS} | tr '[:alnum:]' '*')
        github_internal_echo "password:  \c" 34
        github_internal_echo "${password}" 32 \
            || github_internal_echo "NULL" 31

        github_internal_echo "project:   \c" 34
        github_internal_echo "${SCRIPT_VAR_PROJ}" 32 \
            || github_internal_echo "NULL" 31

        return 0
    fi

    github_internal_set "${1}" "${2}" \
        && github_internal_echo "Value of \"${1}\" defined with sucess.\n" 32
}