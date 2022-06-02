FROM alpine:3.16

WORKDIR /root

RUN apk upgrade --no-cache  \
    && apk add --no-cache \
           groff aws-cli openssl-dev \
           bash bash-completion \
           jq git vim curl ca-certificates \
           tcpdump bind-tools redis \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
           pixz \
    && apk add --no-cache --update --virtual .build-deps \
           python3-dev gcc py-pip \
           musl-dev libffi-dev \
    && CRYPTOGRAPHY_DONT_BUILD_RUST=1 pip3 install --no-cache-dir cryptography==3.3.2 aws-encryption-sdk-cli \
    && apk del .build-deps \
    && curl -fsSL https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod u+x /usr/local/bin/kubectl \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it

COPY bashrc .bashrc

ENTRYPOINT ["/bin/bash"]

CMD ["-c", "trap : TERM INT; sleep infinity & wait" ]