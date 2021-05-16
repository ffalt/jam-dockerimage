# start from node docker image
FROM ffalt/jam-base:latest

# set production environment
ENV NODE_ENV=production
CMD sh /home/node/start.sh
EXPOSE 4040

# install app deamon
RUN npm install --production --silent pm2 -g

# ensure some paths
RUN mkdir /home/node/jam
RUN mkdir /home/node/jam/logs
RUN mkdir /home/node/jam/data
RUN mkdir /home/node/.pm2
# rights for the user
RUN chown -R node:node /home/node/jam/data
RUN chown -R node:node /home/node/jam/logs
RUN chown -R node:node /home/node/.pm2

# copy pm2 helpers
ADD ./static/start.sh /home/node/start.sh
ADD ./static/processes.json /home/node/processes.json
ADD ./static/module_conf.json /home/node/.pm2/module_conf.json

# copy jam startup config
ADD ./static/firststart.config.js /home/node/jam/data/config/firststart.config.js

ENV JAMSERVE_VERSION=v0.4.13
ENV JAMBERRY_VERSION=v0.4.8

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

# install app dependencies
WORKDIR /home/node/jam/serve
RUN npm install --production

# change to user
USER node
# set home directory for user
ENV HOME=/home/node

# run pm2 to get rid of the ad displayed on first start
RUN pm2 ls > /dev/null

