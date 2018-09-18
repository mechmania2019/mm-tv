#!/bin/sh

set -eu

logpath=/cache/log
visualizer=/visualizer/MM_LinuxCombined_PlayerSettings.x86_64

mkdir -p /cache

while true; do
    curl -sSL https://tv.mechmania.io > $logpath
    $visualizer $logpath
done;