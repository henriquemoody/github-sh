github_external_help_set()
{
    github_internal_echo "Defines a value for an existent variable."
    if [ "${1}" == "full" ]; then
        github_internal_echo
        github_internal_echo "Usage:\n"
        github_internal_echo "  set VAR [ VALUE ]\n"
        github_internal_echo "Existent variables:\n"
        github_internal_echo "  user      : Your GitHub username."
        github_internal_echo "  password  : Your GitHub password."
        github_internal_echo "  project   : Current GitHub project."
    fi
}