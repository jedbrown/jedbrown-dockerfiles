FROM jedbrown/mpich:latest

USER root
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxt-dev \
  && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN useradd -ms /bin/bash ceed
USER ceed
WORKDIR /home/ceed

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='MPICH and development packages, ready for CEED'
