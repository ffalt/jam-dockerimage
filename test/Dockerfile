FROM ubuntu:24.04
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates curl ffmpeg flac libchromaprint-tools mp3val unzip gettext git \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
