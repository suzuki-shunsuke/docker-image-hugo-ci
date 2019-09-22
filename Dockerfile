FROM alpine:3.10.2 AS build-env
ARG HUGO_VERSION=0.58.3
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN tar xvzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
FROM alpine:3.10.2
COPY --from=build-env /hugo /usr/local/bin/hugo
# libstdc++ is required to build
# https://cloud.drone.io/suzuki-shunsuke/suzuki-shunsuke.github.io/3/1/3
# symbol not found
RUN apk add --update libstdc++ && \
    mkdir /lib64 && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    rm -rf /var/cache/apk/*
