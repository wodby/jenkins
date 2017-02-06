#!/usr/bin/env bash

set -ex

startDockerCompose() {
    docker-compose -f test/docker-compose.yml up -d
}

stopDockerCompose() {
    docker-compose -f test/docker-compose.yml down
}

waitForJenkins() {
    done=''

    for i in {24..0}; do
        if curl -s "${1}:${2}" | grep -c 'Authentication required'; then
            done=1
            break
        fi
        sleep 5
    done

    if [[ ! "${done}" ]]; then
        echo "Failed to start Jenkins" >&2
        exit 1
    fi
}

checkJenkinsResponse() {
    curl -s "${1}:${2}/login" | grep -c 'Jenkins'
    curl -s "${1}:${2}/login" | grep -c 'Remember me on this computer'
}

runTests() {
    host=localhost
    port=8080

    startDockerCompose
    waitForJenkins "${host}" "${port}"
    checkJenkinsResponse "${host}" "${port}"
    stopDockerCompose
}

runTests
