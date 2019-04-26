FROM alpine:latest

#
# Install all required dependencies.
#

RUN apk add --update curl \
  && rm -rf /var/cache/apk/*

LABEL maintainer='Jed Brown <jed@jedbrown.org>'
LABEL description='Alpine Linux with cURL'

