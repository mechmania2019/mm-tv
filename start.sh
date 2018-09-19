#!/bin/sh

set -eu

logpath=/cache/log

mkdir -p /cache

while true; do
    curl -sSL https://tv.mechmania.io > $logpath
    $VISUALIZER $logpath
done;