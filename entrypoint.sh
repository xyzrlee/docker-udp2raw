#!/bin/sh

listen="0.0.0.0:3000"
remote=""

echo "REMOTEHOST = ${REMOTEHOST}"
echo "REMOTEIP   = ${REMOTEIP}"
echo "REMOTEPORT = ${REMOTEPORT}"

if [ -z "${REMOTEIP}" ]; then
    if [ -z "${REMOTEHOST}" ]; then
        echo "REMOTEIP or REMOTEHOST must be specified"
        exit 1
    fi
    echo "resolving remote ip by hostname [${REMOTEHOST}]"
    REMOTEIP=$(dig +short ${REMOTEHOST} | head -n 1)
    if [ -z "${REMOTEIP}" ]; then
        echo "cannot resolve remote ip"
        exit 1
    fi
fi
remote="${REMOTEIP}:${REMOTEPORT}"

echo "listen     = ${listen}"
echo "remote     = ${remote}"

udp2raw -l ${listen} -r ${remote} --disable-color $@
