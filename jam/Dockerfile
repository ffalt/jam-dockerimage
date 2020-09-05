# start from node docker image
FROM ffalt/jam-base:latest

# set production environment
ENV NODE_ENV=production

# install app deamon
RUN npm install --production --silent pm2 -g

ENV JAMSERVE_VERSION=v0.3.6-alpha
ENV JAMBERRY_VERSION=v0.3.6-alpha

# get jamserve
RUN git -c advice.detachedHead=false clone -b ${JAMSERVE_VERSION} --depth=1 --single-branch https://github.com/ffalt/jamserve.git /home/node/jam/serve

# get jamberry
RUN git -c advice.detachedHead=false clone -b ${JAMBERRY_VERSION} --depth=1 --single-branch https://github.com/ffalt/jamberry.git /home/node/jam/berry

# install app dependencies
WORKDIR /home/node/jam/serve
RUN npm install --production

# ensure some paths
RUN mkdir /home/node/jam/logs
RUN mkdir /home/node/jam/data
RUN mkdir /home/node/.pm2

# copy pm2 helpers
ADD ./static/start.sh /home/node/start.sh
ADD ./static/processes.json /home/node/processes.json
ADD ./static/module_conf.json /home/node/.pm2/module_conf.json

# copy jam default config
ADD ./static/.env /home/node/jam/serve/.env
ADD ./static/firststart.config.js /home/node/jam/data/config/firststart.config.js

# rights for the user
RUN chown -R node:node /home/node/jam/data
RUN chown -R node:node /home/node/jam/logs
RUN chown -R node:node /home/node/.pm2
# change to user
USER node
# set home directory for user
ENV HOME=/home/node

# run pm2 to get rid of the ad displayed on first start
RUN pm2 ls > /dev/null

CMD sh /home/node/start.sh

EXPOSE 4040
