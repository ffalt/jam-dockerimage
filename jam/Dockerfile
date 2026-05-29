FROM node:26-bookworm-slim AS base

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates curl ffmpeg flac libchromaprint-tools mp3val unzip \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ensure some paths
RUN mkdir -p /home/node/jam/logs \
    && mkdir -p /home/node/jam/data \
    && chown -R node:node /home/node/jam/data \
    && chown -R node:node /home/node/jam/logs

# copy startup script
COPY ./static/start.sh /home/node/start.sh
# copy jam startup config, this is not owned by node:node because it should not be writeable, only readable
COPY ./static/firststart.config.json /home/node/jam/data/config/firststart.config.json

ARG JAMSERVE_VERSION=v0.6.5
ARG JAMBERRY_VERSION=v0.6.5
ENV JAMSERVE_VERSION=${JAMSERVE_VERSION}
ENV JAMBERRY_VERSION=${JAMBERRY_VERSION}

# get jamserve & jamberry
# currently without sha256 check to always get the latest release, but this should be changed in the future to ensure integrity of the downloaded file
RUN curl --fail -L -o /tmp/serve.zip https://github.com/ffalt/jamserve/releases/download/${JAMSERVE_VERSION}/jamserve-release.zip \
    && unzip /tmp/serve.zip -d /home/node/jam/serve \
    && rm /tmp/serve.zip \
    && curl --fail -L -o /tmp/berry.zip https://github.com/ffalt/jamberry/releases/download/${JAMBERRY_VERSION}/jamberry-release.zip \
    && unzip /tmp/berry.zip -d /home/node/jam/berry \
    && rm /tmp/berry.zip

# copy jamserve default config
COPY ./static/.env /home/node/jam/serve/.env

ENV NODE_ENV=production
WORKDIR /home/node/jam/serve

# install app dependencies - arm64 requires native build tools for some packages;
# build tools are installed here and discarded with this stage, keeping the final image clean
FROM base AS builder
ARG TARGETPLATFORM
RUN case ${TARGETPLATFORM} in \
         "linux/arm64") \
            apt-get update && \
            apt-get install --no-install-recommends -y build-essential python3 && \
            npm install --omit=dev \
          ;; \
          *) npm install --omit=dev ;; \
    esac

# final image - copy only node_modules from builder, no build tools included
FROM base AS final
COPY --from=builder /home/node/jam/serve/node_modules ./node_modules

# change to user
USER node
# set home directory for user
ENV HOME=/home/node
CMD ["sh", "/home/node/start.sh"]
EXPOSE 4040
