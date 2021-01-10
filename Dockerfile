FROM phusion/baseimage:master-amd64

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get -y install \
    g++-8 \
    flex \
    git \
    lhasa \
    libfl2 \
    libgmp-dev \
    libmpc3 \
    libmpc-dev \
    libtool \
    make \
    python2.7 \
    texinfo \
    wget ; \
    ln -s /usr/bin/python2.7 /usr/bin/python; \
    ln -s /usr/bin/g++-8 /usr/bin/g++; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

# Install python2 pip
RUN cd /tmp; \
    curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py; \
    python get-pip.py; \
    pip2 install argcomplete; \
    rm -rf /tmp/*;

# Fix for the AmigaOS SDK download
COPY files/native-build /opt/temp/native-build

# Compile adtools ppc-amigaos-gcc8
RUN mkdir -p /opt/adtools; \
    mkdir -p /opt/ppc-amigaos; \
    cd /opt/adtools; \
    git config --global user.email "walkero@gmail.com"; \
    git config --global user.name "Georgios Sokianos"; \
    git clone https://github.com/sba1/adtools .; \
    git submodule init; \
    git submodule update; \
    gild/bin/gild clone; \
    gild/bin/gild checkout binutils 2.23.2; \
    gild/bin/gild checkout gcc 8; \
    cp /opt/temp/native-build /opt/adtools -r; \
    make -C native-build gcc-cross CROSS_PREFIX=/opt/ppc-amigaos -j4; \
    cd /opt; \
    rm -rf /opt/adtools;
