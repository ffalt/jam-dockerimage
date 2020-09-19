FROM ffalt/jam-base:latest
RUN apt-get update && \
    apt-get install -y dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev install-info && \
    cd /tmp && \
    curl -o git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.28.0.tar.gz && \
    tar -zxf git.tar.gz && \
    cd git-2.28.0 && \
    make configure && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    rm -rf git-2.28.0 && \
    apt-get remove -y dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev install-info && \
    apt-get autoremove  -y && \
    rm -rf /var/lib/apt/lists/*
