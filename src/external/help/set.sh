_external_help_set()
{
    local title="Defines a value for an existent variable."
    if [ "${1}" == "--full" ]; then
        _echo "${title}\n" 32
        _echo "Usage:\n" 34
        _echo "  set VAR [ VALUE ]\n"
        _echo "Existent variables:\n" 34
        _echo "  user      : Your GitHub username."
        _echo "  password  : Your GitHub password."
        _echo "  project   : Current GitHub project."
    else
        _echo "${title}"
    fi
}
