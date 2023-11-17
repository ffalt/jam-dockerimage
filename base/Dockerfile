FROM node:18-bullseye-slim
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
       ca-certificates nano ffmpeg flac curl libchromaprint-tools mp3val unzip && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

