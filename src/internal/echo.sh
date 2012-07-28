# github_internal_echo MESSAGE [COLOR [DECORATION]] 
github_internal_echo()
{
    local message="${1}"
    local color="${2}"
    local decoration="${3}"

    if [ "${color}" == "" ]
    then
       color=0
    fi

    if [ "${decoration}" == "" ]
    then
        decoration="normal"
    fi

    echo -e "\033[${color}m${message}\033[0m"

}
