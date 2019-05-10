FROM jedbrown/ceed-base:latest

RUN mkdir .spack \
  && curl https://ceed.exascaleproject.org/spack/ceed2-ubuntu18.10-packages.yaml > .spack/packages.yaml \
  && git clone --depth=1 --branch=develop https://github.com/spack/spack

RUN echo '. ~/spack/share/spack/setup-env.sh' >> ~/.bashrc \
 && spack/bin/spack install ceed^libceed+libxsmm

WORKDIR /ceed

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='CEED distribution built using Spack'