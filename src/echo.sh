# _echo [OPTIONS] MESSAGE1 MESSAGE2 MESSAGE3...
_echo()
{
    local params='-e'
    local message
    local stream=1
    local delimiter='\n'

    while [[ ${1} = -* ]]; do
        if [[ ${1} = '-e' ]] || [[ ${1} = '--error' ]]; then
            stream=2
        elif [[ ${1} = '-d' ]] || [[ ${1} = '--delimiter' ]]; then
            delimiter="${2}"
            shift
        else
            params="${params} ${1}"
        fi
        shift
    done

    message="${1}[0]"
    shift

    while [ ${#} -gt 0 ]; do
        message="${message}${delimiter}${1}[0]"
        shift
    done

    if [ -t 1 ]; then
        message=$(echo "${message}" | sed -E $'s/\[([0-9;]+)\]/\033\[\\1m/g')
    else
        message=$(echo "${message}" | sed -E 's/\[[0-9;]+\]//g')
    fi

    if [ ${stream} == 2 ]; then
        echo ${params} "${message}" 1>&2
    else
        echo ${params} "${message}"
    fi
}
