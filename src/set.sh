# _set VARIABLE [ VALUE ]
_set()
{
    local label="${1}"
    local value="${2}"

    if [  -z "${value}" ]; then
        read -e -p "Value for ${label}: " value
    fi

    case "${label}" in 

        username)
            GITHUB_USERNAME="${value}"
        ;;

        token)
            GITHUB_TOKEN="${value}"
        ;;

        repository)
            GITHUB_REPOSITORY="${value}"
        ;;

        *)
          _echo -e "[31]Invalid variable [34]${label}[0]"
          return 2

    esac

    if [ -t 1 ]; then

        message_ask_temporary="I don't want to export this, use just this time"
        message_notice_temporary="Using config only on this time"

        message_ask_local="I want to export config only for this project"
        message_notice_local="Exporting config to this project, only"

        message_ask_global="I want to export config globally"
        message_notice_global="Exporting export config globally"

        if [[ $(git status 2> /dev/null) ]]; then
            _echo "Do you want to export this config?" \
                    "0 : ${message_ask_temporary}." \
                    "1 : ${message_ask_local}." \
                    "2 : ${message_ask_global}."
            _echo -n "Type your choice (0, 1 or 2) > "
            read choice
            case "${choice}" in
                0)
                    _echo "${message_notice_temporary}"
                ;;
                1)
                    _echo "${message_notice_local}"
                    git config github.${label} "${value}"
                ;;
                2)
                    _echo "${message_notice_global}"
                    git config --global github.${label} "${value}"
                ;;
                *)
                    _set "${label}" "${value}"
                    return $?
                ;;
            esac
        else
            _echo "Do you want to export this config?" \
                    "0 : ${message_ask_temporary}." \
                    "1 : ${message_ask_global}."
            _echo -n "Type your choice (0 or 1) > "
            read choice
            case "${choice}" in
                0)
                    _echo "${message_notice_temporary}"
                ;;
                1)
                    _echo "${message_notice_global}"
                    git config --global github.${label} "${value}"
                ;;
                *)
                    _set "${label}" "${value}"
                    return $?
                ;;
            esac
        fi

    fi

    GITHUB_PROMPT="${SCRIPT_PROMPT}"
    if [ -z "${GITHUB_USERNAME}" ]; then
        GITHUB_PROMPT="${GITHUB_PROMPT}:**"
    else
        GITHUB_PROMPT="${GITHUB_PROMPT}:${GITHUB_USERNAME}"
    fi

    if [ ! -z "${GITHUB_REPOSITORY}" ]; then
        GITHUB_PROMPT="${GITHUB_PROMPT}/${GITHUB_REPOSITORY}"
    fi

    GITHUB_PROMPT="${GITHUB_PROMPT}${SCRIPT_PROMPT_CHAR}"
}
