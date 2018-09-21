#!/bin/sh

set -eu

logpath=/cache/log.txt

mkdir -p /cache

team1="Team 1"
team2="Team 2"
while true; do
    get_team1=0
    get_team2=0
    for header in `curl -sSL -D - https://tv.mechmania.io -o $logpath`; do
        echo $header
        # If the previous line was a header, grab the team name
        if [ $get_team1 -eq 1 ]; then
            echo "Got value for team1"
            team1=$header
        fi;
        if [ $get_team2 -eq 1 ]; then
            echo "Got value for team2"
            team2=$header
        fi;

        # Set the "grabber" flag back to default
        get_team1=0
        get_team2=0

        # Check if the header is what we wanna look for
        if [ $header = "X-team-1:" ]; then
            echo "Got header for team1"
            get_team1=1;
        fi;
        if [ $header = "X-team-2:" ]; then
            echo "Got header for team2"
            get_team2=1;
        fi;
    done;

    echo "Starting game"
    echo "Team 1: $team1"
    echo "Team 2: $team2"
    sleep 10
    $VISUALIZER $logpath $team1 $team2
done;