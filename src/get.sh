# Usage: _get [OPTIONS] LABEL
_get()
{
    local label
    local required=0

    while [[ "${1}" = -* ]]; do
        case "${1}" in
            -r | --required)
                required=1
                shift 1
            ;;
        esac
    done

    label="${1}"

    case "${label}" in
        token)
            value="${GITHUB_TOKEN}"
        ;;
        username)
            value="${GITHUB_USERNAME}"
        ;;
        repository)
            value="${GITHUB_REPOSITORY}"
        ;;
    esac

    if [ ${required} -eq 1 ] && [ -z "${value}" ]; then
        _set "${label}"
        _get "${label}"
        return $?
    fi

    echo "${value}"
}