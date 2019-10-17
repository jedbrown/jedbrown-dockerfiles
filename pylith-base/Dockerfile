FROM jedbrown/mpich:latest

ENV PETSC_DIR=/usr/local/petsc/mpich-int32-real-opt
RUN git clone --depth=1 --branch=knepley/pylith https://bitbucket.org/petsc/petsc && \
  cd petsc && \
  OPT='-O2 -march=native -ffp-contract=fast'; \
  PETSC_INSTALL_PREFIX=$PETSC_DIR; unset PETSC_DIR; \
  python3 configure --prefix=$PETSC_INSTALL_PREFIX \
    --with-cxx-dialect=C++11 \
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

RUN apt-get update && apt-get install -y \
    autoconf \
    libcppunit-dev \
    libpcre3-dev \
    libproj-dev \
    libtool \
    libtool-bin \
    proj-bin \
    proj-data \
    python-numpy \
    python-pip \
    python-setuptools \
    python2 \
    python2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 --recursive https://github.com/geodynamics/pythia && \
  cd pythia && \
  python2 setup.py install && \
  cd /build && \
  rm -rf /build/pythia

RUN git clone --depth=1 --recursive https://github.com/geodynamics/nemesis && \
  cd nemesis && \
  autoreconf -fi && \
  ./configure PYTHON=python2 && \
  make -j4 install && \
  cd /build && \
  rm -rf /build/nemesis

RUN curl -L https://sourceforge.net/projects/swig/files/swig/swig-3.0.2/swig-3.0.2.tar.gz/download > swig-3.0.2.tar.gz && \
  tar xf swig-3.0.2.tar.gz && \
  cd swig-3.0.2 && \
  ./configure && \
  make -j4 && \
  make install && \
  cd /build && \
  rm -rf /build/swig-*

RUN git clone --depth=1 --recursive https://github.com/geodynamics/spatialdata && \
  cd spatialdata && \
  autoreconf -fi && \
  ./configure --enable-swig PYTHON=python2 && \
  make -j4 install && \
  cd /build && \
  rm -rf /build/spatialdata

RUN useradd -ms /bin/bash pylith
WORKDIR /pylith
USER pylith

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='PyLith dependencies'

USER root
RUN apt-get update && apt-get install -y \
    valgrind \
    valgrind-mpi \
    gdb \
  && rm -rf /var/lib/apt/lists/*
USER pylith
