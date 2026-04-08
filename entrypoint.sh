#!/bin/sh

set -e

udp2raw $@ -g

exec udp2raw $@

