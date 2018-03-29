# Jenkins docker container image

[![Build Status](https://travis-ci.org/wodby/jenkins.svg?branch=master)](https://travis-ci.org/wodby/jenkins)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/jenkins.svg)](https://hub.docker.com/r/wodby/jenkins)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/jenkins.svg)](https://hub.docker.com/r/wodby/jenkins)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

!!! For better reliability we release images with stability tags (`wodby/jenkins:2-X.X.X`) which correspond to [git tags](https://github.com/wodby/jenkins/releases). We **STRONGLY RECOMMEND** using images only with stability tags. 

Overview:

* All images are based on Alpine Linux
* Base image: [jenkins/jenkins](https://hub.docker.com/r/jenkins/jenkins)
* [TravisCI builds](https://travis-ci.org/wodby/jenkins) 
* [Docker Hub](https://hub.docker.com/r/wodby/jenkins)

Supported tags and respective `Dockerfile` links:

* `2`, `2.113`, `latest` [_(Dockerfile)_](https://github.com/wodby/jenkins/tree/master/Dockerfile)

## Environment Variables

| Variable            | Default Value | Description                              |
| ------------------- | ------------- | ---------------------------------------- |
| `JENKINS_USER`      | `admin`       |                                          |
| `JENKINS_PASSWORD`  |               | If blank will be generated automatically |
| `JENKINS_EXECUTORS` | `2`           |                                          |

## Pre-installed plugins

```
ansicolor
audit-trail
bitbucket
blueocean
build-token-root
credentials-binding
disk-usage
docker
envinject
jdk-tool
git
git-parameter
github
global-build-stats
greenballs
mask-passwords
matrix-auth
postbuild-task
postbuildscript
rebuild
thinBackup
timestamper
workflow-aggregator
workflow-multibranch
```

## Using in production

Deploy Jenkins to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://cloud.wodby.com/stackhub/8f8e26e8-7600-46f9-b476-477e43ed0c1c/overview).