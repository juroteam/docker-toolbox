FROM redis:7.4.1-alpine

WORKDIR /root

RUN apk upgrade --no-cache  \
    && apk add --no-cache \
           groff aws-cli openssl-dev \
           bash bash-completion ncurses \
           mongodb-tools mariadb-client \
           tini jq git vim curl ca-certificates \
           tcpdump bind-tools py3-setuptools py3-pip \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
           pixz \
    && curl -fsSL https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod u+x /usr/local/bin/kubectl \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it

COPY bashrc .bashrc

ENTRYPOINT [ "tini" ]

CMD ["tail", "-f", "/dev/null"]
