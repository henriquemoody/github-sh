# _set VARIABLE [ VALUE ]
_set()
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

        username)
            GITHUB_USERNAME="${value}"
        ;;

        password)
            GITHUB_PASSWORD="${value}"
        ;;

        project)
            GITHUB_PROJECT="${value}"
        ;;

        *)
          _echo "Invalid variable \"${label}\".\n" 31
          return 2

    esac

    GITHUB_PROMPT="${GITHUBSH_PROMPT}"
    if [ ! -z "${GITHUB_PROJECT}" ]; then
        GITHUB_PROMPT="${GITHUB_PROMPT}/${GITHUB_PROJECT}"
    fi
    GITHUB_PROMPT="${GITHUB_PROMPT}${GITHUBSH_PROMPT_CHAR}"

    return 0
}
