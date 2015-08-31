FROM ubuntu:14.04.2
MAINTAINER Alex McLain <alex@alexmclain.com>

ENV CROSSTOOL crosstool-ng-1.21.0

RUN apt-get -qq update
RUN apt-get -y install wget curl \
                       git \
                       build-essential \
                       automake \
                       libtool \
                       gawk \
                       bison \
                       flex \
                       texinfo \
                       gperf \
                       libncurses5-dev \
                       libexpat1-dev \
                       subversion \
                       gnupg

RUN mkdir -p /opt/src/${CROSSTOOL}

# Install crosstool-ng
RUN mkdir -p /opt/src/${CROSSTOOL} && \
    curl -s http://crosstool-ng.org/download/crosstool-ng/${CROSSTOOL}.tar.bz2 | tar -xj -C /opt/src
RUN cd /opt/src/${CROSSTOOL} && \
    ./configure --prefix=/opt/crosstool-ng && make && make install
ENV PATH="${PATH}:/opt/crosstool-ng/bin"

# Build
COPY ./crosstool-ng.conf /root/crosstool-ng.conf

WORKDIR /root
RUN DEFCONFIG=`pwd`/crosstool-ng.conf ct-ng defconfig
RUN CT_ALLOW_BUILD_AS_ROOT_SURE=LOL ct-ng build
