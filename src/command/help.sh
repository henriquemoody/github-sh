_command_help()
{
    local sub_help=_command_help_"${1}"

    if [ ! -z "${2}" ]; then
        sub_help="${sub_help}_${2}"
    fi

    if [ ! -z "${1}" ]; then
        type "${sub_help}" &>/dev/null &&
            ${sub_help} --full ||
            _echo -e "[31]There is no help for [34]${1}[0]"
    else
        _echo -d '\n    ' \
            '[32]GitHub Shell Help[0]\n' \
                "[34]set     [0]$(_command_help_set)" \
                "[34]issue   [0]$(_command_help_issue)"
    fi

    _echo
    
}
