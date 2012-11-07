_external_help()
{
    local sub_help=_external_help_"${1}"

    if [ ! -z "${2}" ]; then
        sub_help="${sub_help}_${2}"
    fi

    if [ ! -z "${1}" ]; then
        type "${sub_help}" &>/dev/null \
          && ${sub_help} --full \
          || _echo "There is no help for \"${1}\"" 31
    else
        _echo "GitHub Shell Help" 32
        _echo "
    set     $(_external_help_set)
    issue   $(_external_help_issue)"
    fi

    _echo
    
}
