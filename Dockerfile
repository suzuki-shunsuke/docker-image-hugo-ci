FROM alpine:3.7 AS build-env
ARG HUGO_VERSION=0.48
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN tar xvzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
FROM alpine:3.7
COPY --from=build-env /hugo /usr/local/bin/hugo
RUN apk add --update git openssh rsync && \
    apk add --no-cache ca-certificates && \
    rm -rf /var/cache/apk/*
