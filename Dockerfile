FROM alpine:3.22

WORKDIR /root

ARG TARGETARCH
ARG ATLAS_CLI_VERSION=1.53.0

RUN apk upgrade --no-cache  \
    && apk add --no-cache \
           groff aws-cli \
           kubectl redis pixz mongodb-tools \
           bash bash-completion ncurses \
           mariadb-client gnupg \
           tini jq yq git vim curl ca-certificates \
           tcpdump bind-tools py3-setuptools py3-pip \
    && if [ "$TARGETARCH" = "arm64" ]; then \
         CLI_ARCH="arm64"; \
       elif [ "$TARGETARCH" = "amd64" ]; then \
         CLI_ARCH="x86_64"; \
       fi \
    && curl -fsSL "https://fastdl.mongodb.org/mongocli/mongodb-atlas-cli_${ATLAS_CLI_VERSION}_linux_${CLI_ARCH}.tar.gz" \
       | tar xz -C /tmp \
    && cp /tmp/mongodb-atlas-cli_*/bin/atlas /usr/local/bin/ \
    && rm -rf /tmp/mongodb-atlas-cli_* \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it \
    && rm -rf /var/cache/apk/*

COPY bashrc .bashrc

ENTRYPOINT ["/sbin/tini","-g","--"]

CMD ["sleep", "infinity"]
