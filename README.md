# Jenkins docker container image

[![Build Status](https://travis-ci.org/wodby/jenkins.svg?branch=master)](https://travis-ci.org/wodby/jenkins)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/jenkins.svg)](https://hub.docker.com/r/wodby/jenkins)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/jenkins.svg)](https://hub.docker.com/r/wodby/jenkins)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Supported tags and respective `Dockerfile` links:

- [`2.46`, `latest` (*2.46/Dockerfile*)](https://github.com/wodby/jenkins/tree/master/2.46/Dockerfile)
- [`2.32`, (*2.32/Dockerfile*)](https://github.com/wodby/jenkins/tree/master/2.32/Dockerfile)

## Environment variables available for customization

| Environment Variable | Default Value | Description |
| -------------------- | ------------- | ----------- |
| JENKINS_USER      | admin |                                          |
| JENKINS_PASSWORD  |       | If blank will be generated automatically |
| JENKINS_EXECUTORS | 2     |                                          |

## Using in production

Deploy Jenkins to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
