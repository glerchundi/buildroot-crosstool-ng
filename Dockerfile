FROM ubuntu:14.04.2
MAINTAINER Alex McLain <alex@alexmclain.com>

ENV CROSSTOOL crosstool-ng-1.22.0

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
                       gnupg \
                       help2man

# Build
ENV TRAVIS_TAG v1.22.0.0
ENV TRAVIS_BUILD_DIR /root

COPY ./ ${TRAVIS_BUILD_DIR}

CMD bash -e ${TRAVIS_BUILD_DIR}/.travis.yml.install && \
    bash -e ${TRAVIS_BUILD_DIR}/.travis.yml.script && \
    bash -e ${TRAVIS_BUILD_DIR}/.travis.yml.after_success && \
    bash
