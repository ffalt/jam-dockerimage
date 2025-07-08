FROM node:22-bullseye-slim
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates curl ffmpeg flac libchromaprint-tools mp3val nano unzip \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER node