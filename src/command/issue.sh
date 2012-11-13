# _command_issue ACTION
_command_issue()
{
    local action
    local command_name

    if [ -z "${1}" ]; then
        _echo -e '[31]You should define a issue action.[0]' \
                    '[31](See "help issue" for more information)[0]' \
                    ''
        return 2
    fi

    action="${1}"
    shift 1

    command_name="_command_issue_${action}"
    shift 1

    ${command_name} $@ | 
        _json_sanitize | 
        while read line; do
            parsed=$(echo "${line}" | _json_parse issue | egrep '^(issue_title|issue_number)')
            eval "${parsed}"
            _echo "[32]#${issue_number}[0] [34]${issue_title}[0]"
        done
}
