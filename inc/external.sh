SHELL_HELP="Usage: ${SCRIPT_NAME} [OPTIONS]
${SCRIPT_DESCRIPTION}

    help    Displays this help.

    set     Defines default values for variables:
                set VAR [ VALUE ]

    issue   Displays information about an issue
                issue NUMBER [ PROJECT [ USER ] ]
"

# set VAR [ VALUE ]
__external_set()
{
    if [ -z "${1}" ]
    then
        for key in "${!github_vars[@]}"; do
            value="${github_vars[${key}]}";
            if [ ${key} == "password" ]
            then
                value=$(echo "${value}" | tr '[:print:]' '*')
            fi
            echo "${key}: ${value}"
        done
        return 0
    fi

    __internal_set "${1}" "${2}" \
        && echo "Value of \"${1}\" defined with sucess."
}

# issue NUMBER [ PROJECT [ USER ] ]
__external_issue()
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
    	if [ -z ${github_vars["project"]} ]
		then
			__external_set project
		fi
		project="${github_vars["project"]}"
	fi

    if [ -z "${user}" ]
    then
    	if [ -z ${github_vars["user"]} ]
		then
			__external_set user
		fi
		user="${github_vars["user"]}"
	fi

	url="https://api.github.com/repos/${user}/${project}/issues/${number}/comments"
	echo $url
	curl -L "${url}" | grep "body" | cut -d "\"" -f 4 | while read line 
	do
		echo "${line}"
		echo
	done

}

# Github shell
__shell()
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

        case "${command_name}" in

            set | issue)
                __external_${command_name} ${command_args}
            ;;

            exit)
                echo "Bye!"
                exit 0
            ;;

            help)
                echo "${SHELL_HELP}"
                exit 0
            ;;

            *)
                echo "Command not found" 1>&2
                continue
            ;;

        esac

        history -s "${input}"

    done
}