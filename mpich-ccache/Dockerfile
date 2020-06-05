ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN apt-get update && apt-get install -y \
  ccache \
  && rm -rf /var/lib/apt/lists/*

ENV MPICH_CC=/usr/lib/ccache/gcc \
    MPICH_CXX=/usr/lib/ccache/g++ \
    CCACHE_BASEDIR=${PWD} \
    CCACHE_DIR=${PWD}/ccache \
    PATH="/usr/lib/ccache:${PATH}"
