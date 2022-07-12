ARG BASE_IMAGE=jedbrown/mpich:latest
ARG PETSC_GIT_BRANCH=release
FROM ${BASE_IMAGE}

RUN apt-get update && apt-get install -y --no-install-recommends \
  automake \
  && rm -rf /var/lib/apt/lists/*

ENV PETSC_DIR=/usr/local/petsc/mpich-int32-real-opt
RUN git clone --depth=1 --branch=${PETSC_GIT_BRANCH} https://gitlab.com/petsc/petsc.git && \
  cd petsc && \
  OPT='-O2 -march=native -ffp-contract=fast'; \
  PETSC_INSTALL_PREFIX=$PETSC_DIR; unset PETSC_DIR; \
  python3 configure --prefix=$PETSC_INSTALL_PREFIX \
    --with-cxx-dialect=C++14 \
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
    --download-sundials2 \
    --download-suitesparse \
    --download-superlu \
    --download-superlu_dist \
    --download-triangle \
    --with-zlib \
    && \
  make
RUN cd petsc && make install
RUN chrpath --delete \
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
    $PETSC_DIR/lib/libhdf5_hl.so \
    $PETSC_DIR/lib/libnetcdf.so \
    $PETSC_DIR/lib/libparmetis.so \
    $PETSC_DIR/lib/libpetsc.so \
    && \
  cd /build && \
  rm -rf /build/petsc

FROM ${BASE_IMAGE}
COPY --from=0 / /

RUN useradd -ms /bin/bash petsc
USER petsc
WORKDIR /home/petsc

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='PETSc built with MPICH and packages'
