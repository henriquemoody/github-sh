github_external_help_issue()
{
    github_internal_echo "Make actions for GitHub issues."
    if [ "${1}" == "full" ]; then
        github_internal_echo "There us a full descritpion"
    fi
}