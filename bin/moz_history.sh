#!/bin/bash
set -e # exit immediately upon failure


# make a copy since original db is locked
DBHOT="/home/abergman/.mozilla/firefox/gztbiijd.h-1533730134974/places.sqlite"
DB="/dev/shm/places.sqlite"
cp $DBHOT $DB
cp $DBHOT-wal $DB-wal

firefox_history() {
sqlite3 -init '' $DB << EOF
.mode tabs
SELECT 
  datetime(moz_historyvisits.visit_date/1000000, 'unixepoch', 'localtime') as vdate
  , title
  , url
FROM moz_places
JOIN moz_historyvisits 
ON moz_places.id = moz_historyvisits.place_id 
ORDER BY moz_historyvisits.visit_date DESC 
LIMIT 300;
EOF
}

firefox_bookmarks() {
sqlite3 -init '' $DB << EOF
.mode tabs
SELECT 
  datetime(b.dateAdded/1000000,'unixepoch', 'localtime') as dateAdded
  , b.title
  , h.url
FROM moz_places h
JOIN moz_bookmarks b
ON h.id = b.fk
ORDER BY last_visit_date DESC;
EOF
}

if [[ $# == 0 ]]; then 
  firefox_history
elif [[ $1 == 'bookmarks' ]]; then
  firefox_bookmarks
fi
