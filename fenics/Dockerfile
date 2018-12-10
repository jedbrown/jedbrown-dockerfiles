FROM jedbrown/petsc:master

USER root
RUN apt-get update && apt-get install -y \
  libboost-chrono-dev \
  libboost-filesystem-dev \
  libboost-iostreams-dev \
  libboost-program-options-dev \
  libboost-timer-dev \
  pybind11-dev \
  python3-pip \
  python3-scipy \
  && rm -rf /var/lib/apt/lists/*

# Python dependencies
RUN pip3 install git+https://bitbucket.org/fenics-project/dijitso#Egg=fenics-dijitso
RUN pip3 install git+https://bitbucket.org/fenics-project/fiat#Egg=fenics-fiat
RUN pip3 install git+https://bitbucket.org/fenics-project/ufl#Egg=fenics-ufl
RUN pip3 install git+https://bitbucket.org/fenics-project/ffc#Egg=fenics-ffc

WORKDIR /build
RUN git clone --depth=1 --branch=jed/petsc-3.10 https://bitbucket.org/jedbrown/dolfin && \
  mkdir dolfin/build && \
  cd dolfin/build && \
  cmake .. && \
  make -j4 && \
  make install && \
  chrpath --replace $PETSC_DIR/lib /usr/local/lib/libdolfin.so && \
  cd ../python && \
  pip3 install . && \
  cd /build && \
  rm -rf dolfin && \
  ldconfig

RUN useradd -ms /bin/bash fenics
USER fenics
WORKDIR /home/fenics

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='FEniCS master built with MPICH, PETSc master+packages'
