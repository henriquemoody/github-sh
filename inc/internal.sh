declare -A github_vars=(
    ["user"]=""
    ["password"]=""
    ["project"]=""
)

__internal_set()
{
    local label="${1}"
    local value="${2}"

    if [ "${label}" == "password" ] && [ "${value}" == "" ]
    then
        read -s -p "Type your password: " value
        echo ""

    elif [ "${value}" == "" ]
    then
        read -e -p "Value for ${label}: " value
    fi

    github_vars["${label}"]="${value}"

    return 0
}
