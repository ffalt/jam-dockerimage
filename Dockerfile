# start from node docker image
FROM node:13-alpine

ENV JAMSERVE_VERSION=v0.2.29-alpha
ENV JAMBERRY_VERSION=v0.2.27-alpha

# install ffmpeg
COPY --from=mwader/static-ffmpeg:4.1 /ffmpeg /ffprobe /usr/local/bin/

# based on https://github.com/rickydunlop/nodejs-ffmpeg/blob/master/Dockerfile
## install ffmpeg
#RUN apk update && \
#    apk upgrade && \
#    apk add --update ca-certificates && \
#    apk add gnutls-dev zlib-dev yasm-dev lame-dev libogg-dev \
#    x264-dev libvpx-dev libvorbis-dev x265-dev freetype-dev \
#    libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev && \
#    apk add --no-cache --virtual .build-dependencies \
#    build-base coreutils tar bzip2 x264 gnutls nasm && \
#    wget -O- http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar xzC /tmp && \
#    cd /tmp/ffmpeg-${FFMPEG_VERSION} && \
#    ./configure --bindir="/usr/bin" \
#                --enable-version3 \
#                --enable-gpl \
#                --enable-nonfree \
#                --enable-small \
#                --enable-libmp3lame \
#                --enable-libx264 \
#                --enable-libx265 \
#                --enable-libvpx \
#                --enable-libtheora \
#                --enable-libvorbis \
#                --enable-libopus \
#                --enable-libass \
#                --enable-libwebp \
#                --enable-librtmp \
#                --enable-postproc \
#                --enable-avresample \
#                --enable-libfreetype \
#                --enable-gnutls \
#                --disable-debug && \
#    make && \
#    make install && \
#    make distclean && \
#    cd $OLDPWD && \
#    rm -rf /tmp/ffmpeg-${FFMPEG_VERSION} && \
#    apk del --purge .build-dependencies

# set production environment
ENV NODE_ENV=production

# install app deamon
RUN npm install --production --silent pm2 -g

# add user to run the app
RUN addgroup -S app && adduser -S app -G app -u 4545
# RUN useradd -u 4545 --user-group --create-home --shell /bin/false app

# install git & wget
RUN apk --no-cache add git wget

# get jamserve
RUN git -c advice.detachedHead=false clone -b ${JAMSERVE_VERSION} --depth=1 --single-branch https://github.com/ffalt/jamserve.git /home/app/jam/serve
RUN rm -rf /home/app/jam/serve/.git
# get jamberry
RUN git -c advice.detachedHead=false clone -b ${JAMBERRY_VERSION} --depth=1 --single-branch https://github.com/ffalt/jamberry.git /home/app/jam/berry
RUN rm -rf /home/app/jam/berry/.git

# remove git
RUN apk del --purge git
# cleanup apk
RUN rm -rf /var/cache/apk/*

# install app dependencies
WORKDIR /home/app/jam/serve
RUN npm install --production

# ensure some paths
RUN mkdir /home/app/jam/logs
RUN mkdir /home/app/jam/data
RUN mkdir /home/app/.pm2

# copy pm2 helpers
ADD ./static/start.sh /home/app/start.sh
ADD ./static/processes.json /home/app/processes.json
ADD ./static/module_conf.json /home/app/.pm2/module_conf.json

# copy jam default config
ADD ./static/config.js /home/app/jam/config/config.js
ADD ./static/firststart.config.js /home/app/jam/config/firststart.config.js
ADD ./static/jamberry.config.js /home/app/jam/config/jamberry.config.js

# rights for the user
RUN chown -R app:app /home/app/jam/data
RUN chown -R app:app /home/app/jam/logs
RUN chown -R app:app /home/app/.pm2
# change to user
USER app
# set home directory for user
ENV HOME=/home/app

# run pm2 to get rid of the ad displayed on first start
RUN pm2 ls > /dev/null

CMD sh /home/app/start.sh

EXPOSE 4040
