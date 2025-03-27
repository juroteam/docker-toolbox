FROM redis:7.2.4-alpine

WORKDIR /root

ARG TARGETARCH

RUN apk upgrade --no-cache  \
    && apk add --no-cache \
           groff aws-cli openssl-dev \
           bash bash-completion ncurses \
           mongodb-tools mariadb-client \
           tini jq git vim curl ca-certificates \
           tcpdump bind-tools py3-setuptools py3-pip \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
           pixz \
    && if [ "$TARGETARCH" = "arm64" ]; then \
       curl -fsSL https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl -o /usr/local/bin/kubectl \
       && chmod u+x /usr/local/bin/kubectl; \
       elif [ "$TARGETARCH" = "amd64" ]; then \
       curl -fsSL https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
       && chmod u+x /usr/local/bin/kubectl; \
       fi \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it \
    && rm -rf /var/cache/apk/*

COPY bashrc .bashrc

ENTRYPOINT [ "tini" ]

CMD ["tail", "-f", "/dev/null"]
