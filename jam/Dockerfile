# start from jam base docker image
FROM ffalt/jam-base:latest

# set production environment
ENV NODE_ENV=production
CMD ["sh", "/home/node/start.sh"]
EXPOSE 4040

# ensure some paths
RUN mkdir -p /home/node/jam/logs \
    && mkdir /home/node/jam/data \
    && chown -R node:node /home/node/jam/data \
    && chown -R node:node /home/node/jam/logs

# copy pm2 helpers
COPY ./static/start.sh /home/node/start.sh
# copy jam startup config
COPY ./static/firststart.config.json /home/node/jam/data/config/firststart.config.json

ENV JAMSERVE_VERSION=v0.5.26
ENV JAMBERRY_VERSION=v0.4.27

# get jamserve
RUN curl -L -o /tmp/serve.zip https://github.com/ffalt/jamserve/releases/download/${JAMSERVE_VERSION}/jamserve-release.zip \
    && unzip /tmp/serve.zip -d /home/node/jam/serve \
    && rm /tmp/serve.zip

# copy jamserve default config
COPY ./static/.env /home/node/jam/serve/.env

# get jamberry
RUN curl -L -o /tmp/berry.zip https://github.com/ffalt/jamberry/releases/download/${JAMBERRY_VERSION}/jamberry-release.zip \
    && unzip /tmp/berry.zip -d /home/node/jam/berry \
    && rm /tmp/berry.zip

ARG TARGETPLATFORM
WORKDIR /home/node/jam/serve

# install app dependencies
RUN case ${TARGETPLATFORM} in \
         "linux/arm64")  \
            apt-get update && \
            apt-get install --no-install-recommends -y build-essential python python3 && \
            npm install --production && \
            apt-get remove -y build-essential python python3 && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* \
          ;; \
          *) npm install --production ;; \
    esac

# change to user
USER node
# set home directory for user
ENV HOME=/home/node