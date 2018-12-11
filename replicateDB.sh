#!/bin/bash
URL="mongodb://heroku_rqqqq:longpasswordstuff@ds136688.mlab.com:36688/heroku_rqqqq"
LOCALDB="test"
remotedb=$(echo $URL | cut -d'/' -f4)
hostname=$(echo $URL |  cut -d'/' -f 2,3 | tr -d '/')
#echo $remotedb  $hostname

COLLECTIONS=$(mongo $hostname/$remotedb --quiet --eval "db.getCollectionNames()" | tr -d '\[\]\"[:space:]' | tr ',' ' ')

for collection in $COLLECTIONS; do
    echo " Exporting $DB/$collection ..."
     mongoexport -d $DB -c $collection -o $collection.json
done

COLLECTIONS_LOCAL=$(mongo localhost:27017/$LOCALDB --quiet --eval "db.getCollectionNames()" | tr -d '\[\]\"[:space:]' | tr ',' ' ')

for collection in $COLLECTIONS_LOCAL; do
    echo " Importing  $LOCALDB/$collection ..."
     mongoimport -d $LOCALDB -c $collection --file $collection.json

done
