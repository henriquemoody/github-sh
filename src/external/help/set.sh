github_external_help_set()
{
    local title="Defines a value for an existent variable."
    if [ "${1}" == "--full" ]; then
        github_internal_echo "${title}\n" 32
        github_internal_echo "Usage:\n" 34
        github_internal_echo "  set VAR [ VALUE ]\n"
        github_internal_echo "Existent variables:\n" 34
        github_internal_echo "  user      : Your GitHub username."
        github_internal_echo "  password  : Your GitHub password."
        github_internal_echo "  project   : Current GitHub project."
    else
        github_internal_echo "${title}"
    fi
}