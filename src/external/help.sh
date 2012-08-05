github_external_help()
{
    local MESSAGE
    local HELP_FUNCTION=github_external_help_"${1}"

    if [ ! -z "${1}" ]; then
        MESSAGE=$(
            type "${HELP_FUNCTION}" &>/dev/null \
                && ${HELP_FUNCTION} full \
                || github_internal_echo "There is no help for \"${1}\"" 31
        )
    else
        MESSAGE="GitHub Shell Help

    set     $(github_external_help_set)
    issue   Make operations with Github issues."
    fi

    github_internal_echo "${MESSAGE}\n"
}