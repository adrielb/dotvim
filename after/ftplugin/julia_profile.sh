tac /tmp/profile_flat.txt | awk '{ print $1" "$2" "$5" at "$3":"$4; }'
