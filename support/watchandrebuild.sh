#!/usr/bin/env bash

OUTPUTDIR="$2"
MAKER="$3"

# Do initial build
for i in "$1"/*.md; do
	$3 "$i" $2
done

inotifywait --monitor --event modify --format "%w%f" --recursive $1 | while read -r filename; do
    if [[ "$filename" =~ \.md$ ]]; then
	   if [[ -f "$filename" ]]; then
                $3 "$filename" $2
           fi
    fi
done


