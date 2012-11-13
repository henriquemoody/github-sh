_json_parse()
{
    local parent="${1}"
    local content="${2}"

    if [ -f "${content}" ]; then
        content=$(cat ${content})
    elif [ -z "${content}" ]; then
        content=$(cat /dev/stdin)
    fi

    sub_pattern="(\"([^\"]+)\":(\{[^}]+\})),?"

    content=$(echo "${content}" | _json_sanitize)
    content_filtered=$(echo "${content}" | sed -E "s/${sub_pattern}//g")

    echo "${content_filtered}" | 
        sed -E '
            s/:true(,|\{|\})/:"1"\1/g
            s/:false(,|\{|\})/:"0"\1/g
            s/:null(,|\{|\})/:"0"\1/g
            s/:([0-9]+)(,|\{|\})/:"\1"\2/g
            s/^\{?([^}]+)\}?$/\1/g' |
        sed -E "s/\"([a-z_]+)\":(\"[^\"]*\"),?/${parent}_\1=\2;/g" |
        tr ';' '\n'

    if [ "${content}" != "${content_filtered}" ]; then
        sub_parent=$(echo "${content}" | sed -E "s/.*${sub_pattern}.*/\2/g")
        sub_content=$(echo "${content}" | sed -E "s/.*${sub_pattern}.*/\3/g")
        if [ ! -z "${parent}" ]; then
            sub_parent="${parent}_${sub_parent}"
        fi
        _json_parse "${sub_parent}" "${sub_content}"
    fi
}