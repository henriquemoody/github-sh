github_external_help()
{
    local sub_help=github_external_help_"${1}"

    if [ ! -z "${2}" ]; then
        sub_help="${sub_help}_${2}"
    fi

    if [ ! -z "${1}" ]; then
        type "${sub_help}" &>/dev/null \
          && ${sub_help} --full \
          || github_internal_echo "There is no help for \"${1}\"" 31
    else
        github_internal_echo "GitHub Shell Help" 32
        github_internal_echo "
    set     $(github_external_help_set)
    issue   $(github_external_help_issue)"
    fi

    github_internal_echo
    
}