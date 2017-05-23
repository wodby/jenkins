#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

fixPermissions() {
    mkdir -p "${JENKINS_HOME}"
    chown jenkins:jenkins "${JENKINS_HOME}"

    if [[ -d /mnt/jobs ]]; then
        chown jenkins:jenkins /mnt/jobs
    fi

    if [[ -d /mnt/backups ]]; then
        chown jenkins:jenkins /mnt/backups
    fi
}

generateDefaultUserPassword() {
    passFile="${JENKINS_HOME}/.password"

    if [[ -z "${JENKINS_PASSWORD}" ]]; then
        export JENKINS_PASSWORD=$(pwgen -s 32 1)
    fi

    if [[ ! -f "${passFile}" ]]; then
        printNotice "Generated default user password:" \
            "    login: ${JENKINS_USER}" \
            "    password: ${JENKINS_PASSWORD}"
    fi

    echo "${JENKINS_PASSWORD}" > "${passFile}"
}

generateSshKey() {
    if [[ ! -d "${JENKINS_HOME}/.ssh" ]]; then
        su-exec jenkins ssh-keygen -q -t rsa -N "" -f "${JENKINS_HOME}/.ssh/id_rsa"

        pubRsaKey=$(cat "${JENKINS_HOME}/.ssh/id_rsa.pub" | xargs)
        printNotice "Generated Jenkins rsa public key: ${JENKINS_HOME}/.ssh/id_rsa.pub:" '' "${pubRsaKey}"
    fi
}

printNotice() {
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

if [[ $1 == "make" ]]; then
    su-exec jenkins "${@}" -f /usr/local/bin/actions.mk
else
    fixPermissions
    generateDefaultUserPassword
    generateSshKey

    exec "$@"
fi
