_external_help_issue()
{
    local title="Performs actions on issues."
    if [ "${1}" == "--full" ]; then
        _echo "${title}\n" 32
        _echo "Usage:\n" 34
        _echo "  issue ACTION [ OPTIONS ]\n"
        _echo "Existent actions:\n" 34
        _echo "  list      : List issues of a project."
        _echo "  open      : Create an issue in a project."
        _echo "  close     : Closes an issue of a project."
        _echo "  comments  : Displays a list of comments of an issue."
    else
        _echo "${title}"
    fi
}
