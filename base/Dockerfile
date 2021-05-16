FROM node:14
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      nano \
      ffmpeg \
      flac \
      libchromaprint-tools  \
      mp3val && \
    apt-get remove git wget -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
