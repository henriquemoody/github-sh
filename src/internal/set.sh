# github_internal_set VARIABLE [ VALUE ]
github_internal_set()
{
    local label="${1}"
    local value="${2}"

    if [ "${label}" == "password" ] && [ "${value}" == "" ]; then
        read -s -p "Type your password: " value
        echo ""
    elif [ "${value}" == "" ]; then
        read -e -p "Value for ${label}: " value
    fi

    case "${label}" in 

        user)
            SCRIPT_VAR_USER="${value}"
        ;;

        password)
            SCRIPT_VAR_PASS="${value}"
        ;;

        project)
            SCRIPT_VAR_PROJ="${value}"
        ;;

        *)
          github_internal_echo "Invalid variable \"${label}\".\n" 31
          return 2

    esac

    SCRIPT_VAR_PROMPT="${SCRIPT_PROMPT}"
    if [ ! -z "${SCRIPT_VAR_PROJ}" ]; then
        SCRIPT_VAR_PROMPT="${SCRIPT_VAR_PROJ}"
    fi
    SCRIPT_VAR_PROMPT="${SCRIPT_VAR_PROMPT}${SCRIPT_PROMPT_CHAR}"

    return 0
}
