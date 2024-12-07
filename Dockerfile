FROM alpine:3.18 AS builder
ARG VERSION
RUN apk update && \
    apk add --no-cache --virtual .build-deps ca-certificates curl && \
    mkdir /app && \
    cd /app && \
    curl -L -o peazip_GTK2.deb https://github.com/peazip/PeaZip/releases/download/$VERSION/peazip_$VERSION.LINUX.GTK2-1_amd64.deb && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/*


FROM jlesage/baseimage-gui:ubuntu-20.04-v4

COPY startapp.sh /startapp.sh
COPY --from=builder /app/peazip_GTK2.deb /tmp/

ENV APP_NAME="PeaZip" \
    TZ=Asia/Shanghai \
    LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                                                xfce4 \
                                                p7zip \
                                                fonts-wqy-zenhei \
                                            && \
    dpkg -i /tmp/peazip_GTK2.deb && \
    rm /tmp/peazip_GTK2.deb && \
    chmod +x /startapp.sh && \
    apt-get autoclean && \
    rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*