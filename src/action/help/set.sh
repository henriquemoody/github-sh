_action_help_set()
{
    local title="Defines a value for an existent variable."
    if [ "${1}" == "--full" ]; then
        _echo "[32]${title}[0]\n"
        _echo "[34]Usage[0]\n"
        _echo "  set VAR [ VALUE ]\n"
        _echo "[34]Existent variables[0]\n"
        _echo "  user      : Your GitHub username."
        _echo "  password  : Your GitHub password."
        _echo "  project   : Current GitHub project."
    else
        _echo "${title}"
    fi
}
