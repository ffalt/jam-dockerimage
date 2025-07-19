FROM ubuntu:24.04
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates curl ffmpeg flac libchromaprint-tools mp3val nano unzip \
        dh-autoreconf gettext git install-info libc6 libcurl4-gnutls-dev libexpat1-dev libssl-dev libz-dev \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
