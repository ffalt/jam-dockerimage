ARG JAMSERVE_VERSION=v0.6.22
ARG JAMBERRY_VERSION=v0.6.22

# download stage - curl & unzip are needed only here and are discarded with this stage
FROM node:26-trixie-slim AS downloader

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates curl unzip \
    && rm -rf /var/lib/apt/lists/*

ARG JAMSERVE_VERSION
ARG JAMBERRY_VERSION

# get jamserve & jamberry
# no integrity check: a checksum published beside the zip adds nothing, as the same compromise
# replaces both. verify with `gh attestation verify` once the releases publish attestations.
RUN mkdir -p /jam \
    && curl --fail -L -o /tmp/serve.zip https://github.com/ffalt/jamserve/releases/download/${JAMSERVE_VERSION}/jamserve-release.zip \
    && unzip /tmp/serve.zip -d /jam/serve \
    && rm /tmp/serve.zip \
    && curl --fail -L -o /tmp/berry.zip https://github.com/ffalt/jamberry/releases/download/${JAMBERRY_VERSION}/jamberry-release.zip \
    && unzip /tmp/berry.zip -d /jam/berry \
    && rm /tmp/berry.zip

FROM node:26-trixie-slim AS base

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates ffmpeg flac libchromaprint-tools mp3val \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/node/jam/logs /home/node/jam/data \
    && chown -R node:node /home/node/jam/logs /home/node/jam/data

# copy startup script
COPY ./static/start.sh /home/node/start.sh

ARG JAMSERVE_VERSION
ARG JAMBERRY_VERSION
ENV JAMSERVE_VERSION=${JAMSERVE_VERSION}
ENV JAMBERRY_VERSION=${JAMBERRY_VERSION}

# copy jamserve & jamberry from the download stage
COPY --from=downloader /jam/serve /home/node/jam/serve
COPY --from=downloader /jam/berry /home/node/jam/berry

# copy jamserve default config
COPY ./static/.env /home/node/jam/serve/.env

ENV NODE_ENV=production
WORKDIR /home/node/jam/serve

# install app dependencies in a separate stage, so npm's cache stays out of the final image.
# the native modules (sqlite3, bcrypt) install prebuilt binaries; these need glibc 2.38, which is
# why the base image is trixie (2.41) and not bookworm (2.36).
FROM base AS builder
RUN npm ci --omit=dev

# final image - take only node_modules from the builder stage, leaving npm's cache behind
FROM base AS final
COPY --from=builder /home/node/jam/serve/node_modules ./node_modules

# change to user
USER node
# set home directory for user
ENV HOME=/home/node
EXPOSE 4040
CMD ["sh", "/home/node/start.sh"]
