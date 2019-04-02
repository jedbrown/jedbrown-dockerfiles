FROM jedbrown/ceed-base:latest

RUN mkdir .spack \
  && curl https://ceed.exascaleproject.org/spack/ceed2-ubuntu18.10-packages.yaml > .spack/packages.yaml
RUN git clone --depth=1 --branch=ceed-2.0 https://github.com/spack/spack \
  && spack/bin/spack install ceed^libceed+libxsmm

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='CEED distribution built using Spack'
