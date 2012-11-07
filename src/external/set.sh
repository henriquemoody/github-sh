# _external_set VAR [ VALUE ]
_external_set()
{
    if [ -z "${1}" ]; then
        _echo "username: \c" 34
        _echo "${GITHUB_USERNAME}" 32 \
            || _echo "NULL" 31

        local password=$(echo ${GITHUB_PASSWORD} | sed 's/./*/g')
        _echo "password: \c" 34
        _echo "${password}" 32 \
            || _echo "NULL" 31

        _echo "project:  \c" 34
        _echo "${GITHUB_PROJECT}" 32 \
            || _echo "NULL" 31

        return 0
    fi

    _set "${1}" "${2}" \
        && _echo "Value of \"${1}\" defined with sucess.\n" 32
}
