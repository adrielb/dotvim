#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi
SESSION=$1
WINDOW=$2

sleep 1
tmux capture-pane -p -S -90 -J -t $SESSION:$WINDOW | \
  awk --assign RS='julia> ' \
    'BEGIN { ORS=RS }  
           {b=a; a=$0}  
       END { print "BASE: /home/abergman/apps/julia-bin/current/share/julia/base\njulia> "b a}'
