FROM ubuntu:26.04
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates curl ffmpeg flac libchromaprint-tools mp3val unzip gettext git libatomic1 \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --uid 1001 --user-group --create-home --shell /bin/bash jam
