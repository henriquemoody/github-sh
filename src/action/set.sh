_action_set()
{
    if [ "${1}" = "--help" ]; then

        local help_type="${2}"
        local help_title="Defines a value for an existent variable."

        case "${help_type}" in

            basic)

                _echo "${help_title}"

                return 0

            ;;

            full)

                _echo "${help_title}\n" 32
                _echo "Usage:\n" 34
                _echo "  set VAR [ VALUE ]\n"
                _echo "Existent variables:\n" 34
                _echo "  user      : Your GitHub username."
                _echo "  password  : Your GitHub password."
                _echo "  project   : Current GitHub project."

                return 0

            ;;

            *)

                echo "Unknown help type \"${help_type}\"" 31

                return 1

            ;;
        esac

    elif [ -z "${1}" ]; then

        _echo "username: \c" 34
        _echo "${GITHUB_USERNAME}" 32 \
            || _echo "NULL" 31

        local password=$(echo ${GITHUB_PASSWORD} | tr '[:alnum:]' '*')
        _echo "password: \c" 34
        _echo "${password}" 32 \
            || _echo "NULL" 31

        _echo "project:  \c" 34
        _echo "${GITHUB_PROJECT}" 32 \
            || _echo "NULL" 31

        return 0

    else

        _set "${1}" "${2}" \
            && _echo "Value of \"${1}\" defined with sucess.\n" 32

        return 0
            
    fi

}
