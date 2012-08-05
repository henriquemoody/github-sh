# github_shell
github_shell()
{
    if [ ! -f "${SCRIPT_HISTORY}" ]; then
        history -r "${SCRIPT_HISTORY}"
    else
        touch "${SCRIPT_HISTORY}"
    fi

    github_internal_echo "Welcome to Github Shell - ${SCRIPT_VERSION}" 32
    github_internal_echo "${SCRIPT_DESCRIPTION}\n"

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
                github_external_${command_name} ${command_args}
            ;;

            *)
                github_internal_echo "Command \"${command_name}\" not found." 31 1>&2
                continue
            ;;

        esac

        history -w "${SCRIPT_HISTORY}"

    done

}
