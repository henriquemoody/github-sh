# Github shell
github_shell()
{
    while read -e -p "${SCRIPT_PROMPT}" input
    do
        command_name=$(echo "${input}" | awk '{print $1}')
        if [ "$(echo "${input}" | wc -w )" != 1 ]
        then
            command_args=$(echo "${input}" | cut -d ' ' -f 2-)
        else
            command_args=""
        fi

		history -s "${input}"

        case "${command_name}" in

            set | issue)
                github_external_${command_name} ${command_args}
            ;;

            exit)
                echo "Bye!"
                exit 0
            ;;

            *)
                echo "Command not found" 1>&2
                continue
            ;;

        esac

    done
}
