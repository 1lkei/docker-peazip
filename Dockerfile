FROM alpine:3.18 AS builder

ARG VERSION

RUN apk update && \
    apk add --no-cache --virtual .build-deps ca-certificates curl && \
    mkdir /app && \
    cd /app && \
    curl -L -o peazip_GTK2.deb https://github.com/peazip/PeaZip/releases/download/$VERSION/peazip_$VERSION.LINUX.GTK2-1_amd64.deb && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/*


FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

COPY --from=builder /app/peazip_GTK2.deb /tmp/
COPY /root /

RUN apt-get update && \
    apt-get install -y p7zip libgtk2.0-0 && \
    dpkg -i /tmp/peazip_GTK2.deb && \
    apt-get autoclean && \
    rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*