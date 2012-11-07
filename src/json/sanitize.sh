_json_sanitize()
{
    local stream="${1}"
    if [ -z "${stream}" ]; then
        stream=/dev/stdin
    fi

    cat "${stream}" |
        tr '\n' ' ' |
        sed -E 's/\[(.+)\]/\1/g' | 
        sed -E 's/ *(:|\{|\}) */\1/g
                s/(,|:) +("|\{)/\1\2/g' |
        awk '{ gsub(/\},\{/,"\}\n\{")}1'
}