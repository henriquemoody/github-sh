#!/usr/bin/env bash
# Description
# ===========
# An interactive shell for GitHub.
# Copyright (C) 2012 Henrique Moody <henriquemoody@gmail.com>.
#
# Authors
# =======
# Henrique Moody <henriquemoody@gmail.com>
#
# Version
# =======
# 0.1.4   Mon Nov 12 15:39:56 BRST 2012
#
# Usage
# =====
#   -h, --help          Displays this help
#   -v, --version       Displays the version of the program
#   -s, --self-update   Self update script
#   -u, --username      Defines the GitHub username
#   -t, --token         Defines the GitHub OAuth token
#   -r, --repository    Defines the GitHub repository
#

source "$(dirname "${0}")/../src/api.sh"
source "$(dirname "${0}")/../src/echo.sh"
source "$(dirname "${0}")/../src/title.sh"
source "$(dirname "${0}")/../src/set.sh"
source "$(dirname "${0}")/../src/get.sh"
source "$(dirname "${0}")/../src/json/parse.sh"
source "$(dirname "${0}")/../src/json/sanitize.sh"
source "$(dirname "${0}")/../src/command/auth.sh"
source "$(dirname "${0}")/../src/command/help.sh"
source "$(dirname "${0}")/../src/command/issue.sh"
source "$(dirname "${0}")/../src/command/issue/list.sh"
source "$(dirname "${0}")/../src/command/set.sh"
source "$(dirname "${0}")/../src/command/exit.sh"
source "$(dirname "${0}")/../src/command/reload.sh"
source "$(dirname "${0}")/../src/shell.sh"

MANPATH="$(realpath "$(dirname "${0}")/../man"):${MANPATH}"
export MANPATH

# Readonly vars
declare -r SCRIPT_BASENAME=$(basename "${0}")
declare -r SCRIPT_REALPATH="$(realpath "${0}" 2>/dev/null || echo "${0}")"
declare -r SCRIPT_HISTORY="${HOME}/.githubsh_history"
declare -r SCRIPT_HEADER="$(sed -n '2,/^$/p' "${SCRIPT_REALPATH}" | sed -E 's/^# ?//g;')"
declare -r SCRIPT_TITLE="GitHub Shell"
declare -r SCRIPT_DESCRIPTION=$(echo "${SCRIPT_HEADER}" | sed -n '/Description/,/^$/p' | sed -n '3,$p')
declare -r SCRIPT_VERSION=$(echo "${SCRIPT_HEADER}" | sed -n '/Version/,/^$/p' | sed -n '3,$p' | awk '{print $1}')
declare -r SCRIPT_COMMANDS="$(compgen -A 'function' | egrep '^_command_[a-z]+$' | cut -d _ -f 3)"
declare -r SCRIPT_PROMPT="github"
declare -r SCRIPT_PROMPT_CHAR="> "
declare -r SCRIPT_HELP="Usage: ${SCRIPT_BASENAME} [OPTIONS]
${SCRIPT_DESCRIPTION}

Options

$(echo "${SCRIPT_HEADER}" | sed -n '/Usage/,/^$/p' | sed -n '3,$p')

Commands

$(echo "${SCRIPT_COMMANDS}" | sed -E 's/(.+)/  \1/g' | sort -r )

Report bugs on https://github.com/henriquemoody/github-sh/issues."

# Global vars
declare GITHUB_TOKEN
declare GITHUB_PROMPT="${SCRIPT_PROMPT}${SCRIPT_PROMPT_CHAR}"
declare GITHUB_USERNAME
declare GITHUB_REPOSITORY

for label in username token repository; do
    if [[ ! -z "$(git config github.${label} 2> /dev/null)" ]]; then
        _set ${label} "$(git config github.${label})" > /dev/null
    fi
done

while [ ! -z "${1}" ]; do

    case "${1}" in

        -u | --username)
            _set username "${2}"
            shift 2
        ;;

        -r | --repository)
            _set repository "${2}"
            shift 2
        ;;

        -t | --token)
            _set token "${2}"
            shift 2
        ;;

        -h | --help)
            _echo "${SCRIPT_HELP}"
            exit 0
        ;;

        -V)
            _echo "${SCRIPT_VERSION}"
            exit 0
        ;;

        -v | --version)
            version=$(echo "${SCRIPT_HEADER}" | sed -n '/Version/,/^$/p' | sed -n '3,$p')
            _echo -n "[32]${SCRIPT_BASENAME}[0]: "
            _echo "${version}"
            exit 0
        ;;

        -s | --self-update)
            TEMPORARY=/tmp/github-sh_$(date +%s)
            curl -L git.io/github-sh -o ${TEMPORARY}
            chmod +x ${TEMPORARY}
            HEAD_VERSION=$(${TEMPORARY} -V)
            if [ "${HEAD_VERSION}" ==  "${SCRIPT_VERSION}" ]; then
                _echo "Nothing to update." 32
                _echo "The last version of ${SCRIPT_BASENAME} is ${HEAD_VERSION}."
                rm -f ${TEMPORARY}
                exit 0
            fi

            if [ ! -w "${0}" ]; then
                _echo "You don't have permission to update ${SCRIPT_BASENAME}." 31 1>&2
                rm -f ${TEMPORARY}
                exit 3
            fi

            mv ${TEMPORARY} "${0}"
            _echo "Successfully updated of ${SCRIPT_VERSION} to ${HEAD_VERSION}" 32
            exit 0
        ;;

        *)
            command_name=$(echo "${SCRIPT_COMMANDS}" | egrep "^${1}$");
            if [ ! -z "${command_name}" ]; then
                command_name="${1}"
                shift 1
                _command_${command_name} $@
                exit

            else
                _echo -e "${SCRIPT_HELP}"
                exit 2
            fi
        ;;

    esac

done

_shell