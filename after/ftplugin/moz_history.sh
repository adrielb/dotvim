#!/bin/bash
set -e # exit immediately upon failure


DBHOT="/home/abergman/.mozilla/firefox/gztbiijd.h-1533730134974/places.sqlite"
DB="/dev/shm/places.sqlite"
cp $DBHOT $DB
cp $DBHOT-wal $DB-wal

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
LIMIT 30;
EOF

