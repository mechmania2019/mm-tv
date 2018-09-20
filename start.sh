#!/bin/sh

set -eu

logpath=/cache/log.txt

mkdir -p /cache

while true; do
    get_team1=0
    get_team2=0
    for header in `curl -sSL -D - https://tv.mechmania.io -o $logpath`; do
        # If the previous line was a header, grab the team name
        if [ $get_team1 -eq 1 ]; then
            team1=$header
        fi;
        if [ $get_team2 -eq 1 ]; then
            team2=$header
        fi;

        # Set the "grabber" flag back to default
        get_team1=0
        get_team2=0

        # Check if the header is what we wanna look for
        if [ $header = "x-team-1:" ]; then
            get_team1=1;
        fi;
        if [ $header = "x-team-2:" ]; then
            get_team2=1;
        fi;
    done;

    echo "Starting game"
    echo "Team 1: $team1"
    echo "Team 2: $team2"
    $VISUALIZER $logpath $team1 $team2
done;