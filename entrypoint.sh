#!/bin/sh

set -e

exec udp2raw $@ -g && udp2raw $@

