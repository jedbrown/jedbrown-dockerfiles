ARG BASE_IMAGE=ubuntu:22.04
ARG PETSC_GIT_BRANCH=main
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
  libopenblas-dev \
  libhdf5-openmpi-dev \
  liblapack-dev \
  libopenmpi-dev \
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

ENV PETSC_DIR=/usr/local
RUN git clone --depth=1 --branch=main https://gitlab.com/petsc/petsc.git
WORKDIR /build/petsc
RUN OPT='-O2 -march=haswell -ffp-contract=fast'; \
  PETSC_INSTALL_PREFIX=$PETSC_DIR; unset PETSC_DIR; \
  python3 configure --prefix=$PETSC_INSTALL_PREFIX \
    --with-debugging=0 COPTFLAGS="$OPT" CXXOPTFLAGS="$OPT" FOPTFLAGS="$OPT" \
    --download-cgns \
    --download-cmake \
    --download-ctetgen \
    --download-hdf5 \
    --download-suitesparse \
    --download-hypre \
    --download-metis \
    --download-ml \
    --download-mumps \
    --download-parmetis \
    --download-scalapack \
    --download-superlu \
    --download-superlu_dist \
    --download-triangle \
    --with-zlib
RUN make
RUN make install
RUN chrpath --delete \
    $PETSC_DIR/lib/libcgns.so \
    $PETSC_DIR/lib/libmetis.so \
    $PETSC_DIR/lib/libsuperlu.so \
    $PETSC_DIR/lib/libsuperlu_dist.so \
    && \
 chrpath --replace $PETSC_DIR/lib \
    $PETSC_DIR/lib/libparmetis.so \
    $PETSC_DIR/lib/libpetsc.so
WORKDIR /build

ENV CEED_DIR=/usr/local
RUN git clone --depth=1 https://github.com/CEED/libCEED.git && \
  make -C libCEED -j install prefix=$CEED_DIR OPT='-O2 -march=haswell -ffp-contract=fast' && \
  make -C libCEED/examples/fluids && \
  mv libCEED/examples/fluids/navierstokes /usr/local/bin/ceed-fluids && \
  ln -s ceed-fluids /usr/local/bin/navierstokes

RUN export PETSC_DIR=/usr/local CEED_DIR=/usr/local && \
  git clone https://gitlab.com/micromorph/ratel && \
  make -C ratel -j install prefix=/usr/local

FROM ${BASE_IMAGE}
COPY --from=0 /usr /usr
COPY --from=0 /etc /etc
RUN git config --global --add safe.directory /data
ENV PETSC_DIR=/usr/local CEED_DIR=/usr/local
ENV OMPI_ALLOW_RUN_AS_ROOT=1 OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1
WORKDIR /data

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='Ubuntu with PETSc, libCEED, and Ratel'
