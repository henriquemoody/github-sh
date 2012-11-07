_external_help_issue()
{
    local title="Performs actions on issues."
    if [ "${1}" == "--full" ]; then
        _echo "[32]${title}\n[0]"
        _echo "[34]Usage\n[0]" 
        _echo "  issue ACTION [ OPTIONS ]\n"
        _echo "[34]Existent actions\n[0]" 
        _echo "  list      : List issues of a project."
        _echo "  open      : Create an issue in a project."
        _echo "  close     : Closes an issue of a project."
        _echo "  comments  : Displays a list of comments of an issue."
    else
        _echo "${title}"
    fi
}
