FROM ubuntu:cosmic

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
  ./configure && \
  make -j4 && \
  make install && \
  cd /build && \
  rm -rf /build/mpich-3.3 && \
  ldconfig

ENV PETSC_DIR=/usr/local/petsc/mpich-int32-real-opt
RUN git clone --depth=1 --branch=master https://bitbucket.org/petsc/petsc && \
  cd petsc && \
  OPT='-O2 -march=native'; \
  PETSC_INSTALL_PREFIX=$PETSC_DIR; unset PETSC_DIR; \
  python3 configure --prefix=$PETSC_INSTALL_PREFIX \
    --with-debugging=0 COPTFLAGS="$OPT" CXXOPTFLAGS="$OPT" FOPTFLAGS="$OPT" \
    --with-mpi-dir=/usr/local \
    --download-ctetgen \
    --download-exodusii \
    --download-hdf5 \
    --download-hypre \
    --download-metis \
    --download-ml \
    --download-mumps \
    --download-netcdf \
    --download-parmetis \
    --download-pnetcdf \
    --download-scalapack \
    --download-sundials \
    --download-suitesparse \
    --download-superlu \
    --download-superlu_dist \
    --download-triangle \
    --with-zlib \
    && \
  make && \
  make install && \
  export PETSC_DIR=$PETSC_INSTALL_PREFIX && \
  unset OPT PETSC_INSTALL_PREFIX && \
  chrpath --delete \
    $PETSC_DIR/lib/libhdf5.so \
    $PETSC_DIR/lib/libmetis.so \
    $PETSC_DIR/lib/libpnetcdf.so \
    $PETSC_DIR/lib/libsuperlu.so \
    $PETSC_DIR/lib/libsuperlu_dist.so \
    && \
  chrpath --replace $PETSC_DIR/lib \
    $PETSC_DIR/lib/libexoIIv2for32.so \
    $PETSC_DIR/lib/libexodus.so \
    $PETSC_DIR/lib/libexodus_for.so \
    $PETSC_DIR/lib/libexodus_for.so \
    $PETSC_DIR/lib/libhdf5_fortran.so \
    $PETSC_DIR/lib/libhdf5_hl.so \
    $PETSC_DIR/lib/libhdf5hl_fortran.so \
    $PETSC_DIR/lib/libnetcdf.so \
    $PETSC_DIR/lib/libparmetis.so \
    $PETSC_DIR/lib/libpetsc.so \
    && \
  cd /build && \
  rm -rf /build/petsc

RUN useradd -ms /bin/bash petsc
USER petsc
WORKDIR /home/petsc

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='PETSc built with MPICH and packages'
