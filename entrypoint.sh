#!/bin/sh

udp2raw $@ -g && udp2raw --disable-color $@
