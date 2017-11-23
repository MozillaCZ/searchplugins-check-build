#!/bin/bash

cd $1;
while read line; do
    url="$(cut -d ',' -f 1 <<< "$line")"
    filename="$(cut -d ',' -f 2 <<< "$line")"
    curl $url --output $filename
done < "./searchplugins.csv";

md5sum --check "./MD5SUMS";

exit $?;

