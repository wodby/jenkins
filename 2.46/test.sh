#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

name=$1
image=$2

cid="$(docker run -d --name "${name}" "${image}")"
trap "docker rm -vf $cid > /dev/null" EXIT

jenkins() {
	docker run --rm -i --link "${name}":"jenkins" "${image}" "${@}"
}

echo -n "Waiting for Jenkins to start... "
jenkins make check-ready wait_seconds=5 max_try=12 delay_seconds=5 host="jenkins"
echo "OK"

echo -n "Checking Jenkins version... "
jenkins curl -s "jenkins:8080" | grep -q "Jenkins ver. 2.46.2"
echo "OK"