github_external_help()
{
    local MESSAGE
    local HELP_FUNCTION=github_external_help_"${1}"

    if [ ! -z "${1}" ]; then

        MESSAGE=$(
            type "${HELP_FUNCTION}" &>/dev/null \
                && ${HELP_FUNCTION} full \
                || echo "There is no help for \"${1}\""
        );

    else
        MESSAGE="
    set     $(github_external_help_set)
    issue   Make operations with Github issues."
    fi

    github_internal_echo "${MESSAGE}\n"
}