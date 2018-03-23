#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

generate_default_password() {
    pass_file="${JENKINS_HOME}/.password"

    if [[ -z "${JENKINS_PASSWORD}" ]]; then
        export JENKINS_PASSWORD=$(pwgen -s 32 1)
    fi

    if [[ ! -f "${pass_file}" ]]; then
        print_notice "Generated default user password:" \
            "    login: ${JENKINS_USER}" \
            "    password: ${JENKINS_PASSWORD}"
    fi

    echo "${JENKINS_PASSWORD}" > "${pass_file}"
}

generate_ssh_key() {
    if [[ ! -d "${JENKINS_HOME}/.ssh" ]]; then
        ssh-keygen -q -t rsa -N "" -f "${JENKINS_HOME}/.ssh/id_rsa"

        key=$(cat "${JENKINS_HOME}/.ssh/id_rsa.pub" | xargs)
        print_notice "Generated Jenkins rsa public key: ${JENKINS_HOME}/.ssh/id_rsa.pub:" '' "${key}"
    fi
}

print_notice() {
    echo ''
    echo '----------------------------------------------'
    echo ''
    echo "${1}"
    if [[ -n "${2}" ]]; then
        echo "${2}"
    fi
    if [[ -n "${3}" ]]; then
        echo "${3}"
    fi
    echo ''
    echo '----------------------------------------------'
    echo ''
}

sudo init_volumes

if [[ $1 == "make" ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    generate_default_password
    generate_ssh_key

    exec "$@"
fi
