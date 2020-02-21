ARG BASE_IMAGE=jedbrown/mpich:latest
FROM ${BASE_IMAGE}

ENV PETSC_DIR=/usr/local/petsc/mpich-int32-real-opt
RUN git clone --depth=1 --branch=master https://gitlab.com/petsc/petsc && \
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
    --download-med \
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
