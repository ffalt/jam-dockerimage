# start from jam base docker image
FROM ffalt/jam-base:latest

# set production environment
ENV NODE_ENV=production
CMD sh /home/node/start.sh
EXPOSE 4040

# ensure some paths
RUN mkdir -p /home/node/jam/logs && \
 mkdir /home/node/jam/data && \
 chown -R node:node /home/node/jam/data && \
 chown -R node:node /home/node/jam/logs

# copy pm2 helpers
ADD ./static/start.sh /home/node/start.sh
# copy jam startup config
ADD ./static/firststart.config.json /home/node/jam/data/config/firststart.config.json

ENV JAMSERVE_VERSION=v0.5.22
ENV JAMBERRY_VERSION=v0.4.24

# get jamserve
RUN cd /tmp && \
  curl -L -o tmp.zip https://github.com/ffalt/jamserve/releases/download/${JAMSERVE_VERSION}/jamserve-release.zip && \
  unzip tmp.zip -d /home/node/jam/serve && \
  rm tmp.zip

# copy jamserve default config
ADD ./static/.env /home/node/jam/serve/.env

# get jamberry
RUN cd /tmp && \
  curl -L -o tmp.zip https://github.com/ffalt/jamberry/releases/download/${JAMBERRY_VERSION}/jamberry-release.zip && \
  unzip tmp.zip -d /home/node/jam/berry && \
  rm tmp.zip

ARG TARGETPLATFORM
WORKDIR /home/node/jam/serve

# install app dependencies
RUN case ${TARGETPLATFORM} in \
         "linux/arm64")  \
            apt-get update && \
            apt-get install --no-install-recommends -y python python3 build-essential && \
            npm install --production && \
            apt-get remove -y python python3 build-essential  && \
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
