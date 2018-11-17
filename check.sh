#!/bin/bash

cd $1;
while read line; do
    url="$(cut -d ',' -f 1 <<< "$line")"
    filename="$(cut -d ',' -f 2 <<< "$line")"
    curl $url --output $filename
    if file --mime-type "$filename" | grep -q gzip$; then
        echo "${filename} is gzipped"
	mv "$filename" "${filename}.gz"
	gunzip "$filename"
    fi
done < "./searchplugins.csv";

md5sum --check "./MD5SUMS";

exit $?;

