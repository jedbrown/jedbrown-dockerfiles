ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN apt-get update && apt-get install -y \
  bash-completion \
  chrpath \
  cmake \
  curl \
  g++ \
  gcc \
  gfortran \
  git \
  libopenblas-dev \
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
RUN curl -O http://www.mpich.org/static/downloads/3.3/mpich-3.3.tar.gz && \
  tar xf mpich-3.3.tar.gz && \
  rm mpich-3.3.tar.gz && \
  cd mpich-3.3 && \
  ./configure --disable-wrapper-rpath && \
  make -j4 && \
  make install && \
  cd /build && \
  rm -rf /build/mpich-3.3 && \
  ldconfig

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='Ubuntu Cosmic with compilers and MPICH'
