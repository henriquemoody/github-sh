# _shell
_shell()
{
    if [ -f "${SCRIPT_HISTORY}" ]; then
        history -r "${SCRIPT_HISTORY}"
    else
        touch "${SCRIPT_HISTORY}"
    fi

    _title "Welcome to ${SCRIPT_TITLE} - ${SCRIPT_VERSION}"

    history -r "${SCRIPT_HISTORY}"

    while read -e -p "${GITHUB_PROMPT}" input; do

        if [ "${input}" == "" ]; then
            continue
        fi

        history -s "${input}"

        set - ${input}
        command_name=$(echo "${SCRIPT_COMMANDS}" | egrep "^${1}$");
        if [ ! -z "${command_name}" ]; then
            command_name="${1}"
            shift 1
            _command_${command_name} $@
        else
            _echo -e "[31]Command \"${command_name}\" not found.[0]"
            continue
        fi

        history -w "${SCRIPT_HISTORY}"

    done

}
