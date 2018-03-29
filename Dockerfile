ARG BASE_IMAGE_TAG

FROM jenkins/jenkins:${BASE_IMAGE_TAG}

ARG JENKINS_VER

ENV JENKINS_VER="${JENKINS_VER}" \
    # Skip initial jenkins setup
    JAVA_OPTS="-Djenkins.install.runSetupWizard=false" \
    JENKINS_USER="admin" \
    JENKINS_EXECUTORS=2

USER root

RUN set -ex; \
    \
    # Group ping has gid 999 that matches with docker gid on Linux.
    # Add user to docker group to give write permissions to mounted /var/run/docker.sock
    adduser jenkins ping; \
    \
    apk add --no-cache \
        curl \
        docker \
        make \
        pwgen \
        su-exec \
        sudo \
        tar \
        wget; \
    \
    su-exec jenkins /usr/local/bin/install-plugins.sh \
        ansicolor \
        audit-trail \
        bitbucket \
        blueocean \
        build-token-root \
        credentials-binding \
        disk-usage \
        docker \
        envinject \
        jdk-tool \
        git \
        git-parameter \
        github \
        global-build-stats \
        greenballs \
        mask-passwords \
        matrix-auth \
        postbuild-task \
        postbuildscript \
        rebuild \
        thinBackup \
        timestamper \
        workflow-aggregator \
        workflow-multibranch; \
    \
    # Script to fix volumes permissions via sudo.
    echo "chown jenkins:jenkins ${JENKINS_HOME}" > /usr/local/bin/init_volumes; \
    chmod +x /usr/local/bin/init_volumes; \
    echo 'jenkins ALL=(root) NOPASSWD:SETENV: /usr/local/bin/init_volumes' > /etc/sudoers.d/jenkins

USER jenkins

# Default settigs init script
COPY default-settings.groovy /usr/share/jenkins/ref/init.groovy.d/

COPY docker-entrypoint.sh /
COPY actions /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
