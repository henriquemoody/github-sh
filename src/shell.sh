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

        command_name=$(echo "${input}" | awk '{print $1}')
        if [ "$(echo "${input}" | wc -w | awk '{print $1}')" != 1 ]; then
            command_args=$(echo "${input}" | cut -d ' ' -f 2-)
        else
            command_args=""
        fi

		history -s "${input}"

        case "${command_name}" in

            set | issue | exit | help | reload)
                _command_${command_name} ${command_args}
            ;;

            *)
                _echo -e "[31]Command \"${command_name}\" not found.[0]"
                continue
            ;;

        esac

        history -w "${SCRIPT_HISTORY}"

    done

}
