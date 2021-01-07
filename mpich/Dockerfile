ARG BASE_IMAGE=ubuntu:20.10
FROM ${BASE_IMAGE}

RUN echo Etc/UTC > /etc/timezone && ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN apt-get update && apt-get install -y --no-install-recommends \
  autoconf \
  bash-completion \
  chrpath \
  cmake \
  curl \
  g++ \
  gcc \
  gfortran \
  git \
  libblis-serial-dev \
  liblapack-dev \
  libtool \
  locales \
  m4 \
  make \
  pkg-config \
  python3-distutils \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

WORKDIR /build
ARG MPICH_DEVICE=ch3:nemesis
ARG MPICH_VERSION=3.3.2
RUN \
  curl -O https://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz && \
  tar xf mpich-${MPICH_VERSION}.tar.gz && \
  rm mpich-${MPICH_VERSION}.tar.gz && \
  cd mpich-${MPICH_VERSION} && \
  ./configure --disable-wrapper-rpath --with-device=${MPICH_DEVICE} && \
  make -j4 && \
  make install && \
  cd /build && \
  rm -rf /build/mpich-${MPICH_VERSION} && \
  ldconfig

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='Ubuntu with compilers and MPICH'
