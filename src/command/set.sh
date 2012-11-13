# _command_set VAR [ VALUE ]
_command_set()
{
    if [ -z "${1}" ]; then
        _title "${SCRIPT_TITLE} Variables"

        _echo -n '  * [34]Username[0]    '
        test "${GITHUB_USERNAME}" &&
            _echo "[32]${GITHUB_USERNAME}[0]" ||
            _echo '[31;3]NULL[0]'

        _echo -n '  * [34]Repository[0]  '
        test "${GITHUB_REPOSITORY}" &&
            _echo "[32]${GITHUB_REPOSITORY}[0]" ||
            _echo '[31;3]NULL[0]'

        _echo -n '  * [34]OAuth Token[0] '
        test "${GITHUB_TOKEN}" &&
            _echo "[32]${GITHUB_TOKEN}[0]" ||
            _echo '[31;3]NULL[0]'

        _echo

        return 0
    fi

    _set "${1}" "${2}" &&
        _echo "[32]Value of [34]${1}[32] defined with sucess.[0]" ||
        _echo "[31]Failure setting value of [34]${1}[0]."
}
