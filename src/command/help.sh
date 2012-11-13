_command_help()
{
    local page="githsh"
    if [ ${#} -gt 0 ]; then
        page=${page}-$(echo "$@" | tr ' ' '-')
    fi
    man "${page}"
}