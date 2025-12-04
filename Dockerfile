FROM alpine:3.23

WORKDIR /root

RUN apk upgrade --no-cache \
 && apk add --no-cache \
           groff aws-cli \
           kubectl redis pixz \
           bash bash-completion ncurses \
           mongodb-tools mariadb-client \
           tini jq yq git vim curl ca-certificates \
           tcpdump bind-tools py3-setuptools py3-pip \
 && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it \
 && rm -rf /var/cache/apk/*

COPY bashrc .bashrc

ENTRYPOINT ["/sbin/tini","-g","--"]

CMD ["sleep", "infinity"]
