FROM jedbrown/mpich:latest

USER root
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxt-dev \
  && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN useradd -ms /bin/bash ceed
WORKDIR /home/ceed
COPY packages.yaml .spack/linux/packages.yaml
RUN chown -R ceed:ceed .spack
USER ceed

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='MPICH and development packages, ready for CEED'
