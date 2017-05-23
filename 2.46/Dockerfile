FROM jenkins:2.46.2-alpine

USER root

RUN apk add --no-cache \
        sudo \
        su-exec \
        pwgen \
        curl \
        tar \
        wget \
        py-pip \
        make \
        rsync \
        docker && \

    # Allow jenkins use sudo
    echo 'jenkins ALL=(root) NOPASSWD: ALL' > /etc/sudoers.d/jenkins && \

    # Remove all docker-related assets except docker client
    rm -rf \
        /usr/bin/docker-runc \
        /usr/bin/dockerd \
        /usr/bin/docker-containerd-shim \
        /usr/bin/docker-containerd-ctr \
        /usr/bin/docker-containerd \
        /usr/bin/docker-proxy \
        /etc/conf.d/docker \
        /etc/init.d/docker && \

    # Install python tools
    pip install --no-cache-dir \
    docker-compose \
    awscli

# Skip initial jenkins setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Default user name
ENV JENKINS_USER admin

# The number of executors
ENV JENKINS_EXECUTORS 2

# Default settigs init script
COPY default-settings.groovy /usr/share/jenkins/ref/init.groovy.d/

# Install default plugins set
RUN su-exec jenkins /usr/local/bin/install-plugins.sh \
        git \
        matrix-auth \
        workflow-aggregator \
        credentials-binding \
        multi-branch-project-plugin \
        rebuild \
        envinject \
        thinBackup \
        postbuild-task \
        audit-trail \
        mask-passwords \
        global-build-stats \
        postbuildscript \
        git-parameter \
        bitbucket \
        github \
        disk-usage \
        build-token-root \
        timestamper \
        greenballs \
        ansicolor

COPY docker-entrypoint.sh /
COPY actions /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["su-exec", "jenkins", "/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
