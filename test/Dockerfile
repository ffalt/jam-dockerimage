FROM ffalt/jam-base:latest
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        dh-autoreconf gettext git install-info libc6 libcurl4-gnutls-dev libexpat1-dev libssl-dev libz-dev \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER node