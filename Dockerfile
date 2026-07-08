FROM alpine:3.24

WORKDIR /root

ARG ATLAS_CLI_VERSION=1.53.0

RUN apk upgrade --no-cache  \
    && apk add --no-cache \
           groff aws-cli \
           kubectl pixz zstd mongodb-tools \
           bash bash-completion ncurses \
           mariadb-client gnupg \
           tini jq yq git vim curl ca-certificates \
           tcpdump bind-tools py3-setuptools py3-pip \
           nodejs npm \
    # Alpine 3.23 has redis 8.4. We use 8.6. redis-check-rdb fails in backup scripts
    && apk add --no-cache redis --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    && npm install -g mongosh @mongodb-js/zstd --ignore-scripts \
    && npm cache clean --force \
    && curl -fsSL "https://fastdl.mongodb.org/mongocli/mongodb-atlas-cli_${ATLAS_CLI_VERSION}_linux_arm64.tar.gz" \
       | tar xz -C /tmp \
    && cp /tmp/mongodb-atlas-cli_*/bin/atlas /usr/local/bin/ \
    && rm -rf /tmp/mongodb-atlas-cli_* \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it \
    && rm -rf /var/cache/apk/*

COPY bashrc .bashrc

ENTRYPOINT ["/sbin/tini","-g","--"]

CMD ["sleep", "infinity"]
