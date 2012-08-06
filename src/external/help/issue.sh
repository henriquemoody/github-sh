github_external_help_issue()
{
    local title="Performs actions on issues."
    if [ "${1}" == "--full" ]; then
        github_internal_echo "${title}\n" 32
        github_internal_echo "Usage:\n" 34
        github_internal_echo "  issue ACTION [ OPTIONS ]\n"
        github_internal_echo "Existent actions:\n" 34
        github_internal_echo "  list      : List issues of a project."
        github_internal_echo "  open      : Create an issue in a project."
        github_internal_echo "  close     : Closes an issue of a project."
        github_internal_echo "  comments  : Displays a list of comments of an issue."
    else
        github_internal_echo "${title}"
    fi
}