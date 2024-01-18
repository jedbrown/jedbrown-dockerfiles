ARG BASE_IMAGE=ubuntu:23.04
FROM ${BASE_IMAGE}

RUN echo Etc/UTC > /etc/timezone && ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  autoconf \
  automake \
  bash-completion \
  ca-certificates \
  chrpath \
  cmake \
  curl \
  g++ \
  gcc \
  gfortran \
  git \
  less \
  libblis-serial-dev \
  liblapack-dev \
  libtool \
  locales \
  m4 \
  make \
  openssl \
  pkg-config \
  python3-distutils \
  ripgrep \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

WORKDIR /build
ARG MPICH_DEVICE=ch3:nemesis
ARG MPICH_VERSION=4.1.2
RUN \
  curl -O https://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz && \
  tar xf mpich-${MPICH_VERSION}.tar.gz && \
  rm mpich-${MPICH_VERSION}.tar.gz && \
  cd mpich-${MPICH_VERSION} && \
  ./configure \
      FFLAGS=-fallow-argument-mismatch \
      FCFLAGS=-fallow-argument-mismatch \
      --disable-wrapper-rpath \
      --with-device=${MPICH_DEVICE} \
      --enable-error-checking=runtime \
      --enable-error-messages=all \
      --enable-g=meminit && \
  make -j$(nproc) && \
  make install && \
  cd /build && \
  rm -rf /build/mpich-${MPICH_VERSION} && \
  ldconfig

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='Ubuntu with compilers and MPICH'
