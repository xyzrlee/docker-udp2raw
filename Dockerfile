#
# Dockerfile for udp2raw
#

FROM alpine AS builder

RUN set -ex \
 # Build environment setup
 && apk update \
 && apk upgrade \
 && apk add --no-cache --virtual .build-deps \
      linux-headers \
      git \
      gcc \
      g++ \
      make \
      libcap \
 # Build & install
 && mkdir -p /tmp/repo \
 && cd /tmp/repo \
 && git clone https://github.com/wangyu-/udp2raw-tunnel.git \
 && cd udp2raw-tunnel \
 && make \
 && setcap cap_net_raw+ep udp2raw \
 && install udp2raw /usr/local/bin

# ------------------------------------------------

FROM alpine

COPY --from=builder /usr/local/bin/udp2raw /usr/local/bin/udp2raw
COPY entrypoint.sh /entrypoint.sh

USER nobody

RUN set -ex \
  && udp2raw --help

ENTRYPOINT [ "/entrypoint.sh" ]
