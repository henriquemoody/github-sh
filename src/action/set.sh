# _external_set VAR [ VALUE ]
_external_set()
{
    if [ -z "${1}" ]; then
        _echo -n '[34]username[0]: '
        test "${GITHUB_USERNAME}" &&
            _echo "[32]${GITHUB_USERNAME}[0]" ||
            _echo '[31;3]NULL[0]'

        _echo -n '[34]password[0]: '
        test "${GITHUB_PASSWORD}" &&
            _echo "[32]$(echo ${GITHUB_PASSWORD} | sed 's/./*/g')[0]" ||
            _echo '[31;3]NULL[0]'

        _echo -n '[34]project[0] : '
        test "${GITHUB_PROJECT}" &&
            _echo "[32]${GITHUB_PROJECT}[0]" ||
            _echo '[31;3]NULL[0]'

        return 0
    fi

    _set "${1}" "${2}" &&
        _echo "[32]Value of [34]${1}[32] defined with sucess.[0]" ||
        _echo "[31]Failure setting value of [34]${1}[0]."
}
