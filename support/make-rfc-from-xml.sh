#!/bin/bash

DIRECTORY=$(dirname "$1")
[[ ! -z "$DIRECTORY" ]] && DIRECTORY=.

BASENAME=$(basename "$1")

FILENAME="${BASENAME%.*}"

OUTPUTDIR=$2
[[ -z "$OUTPUTDIR" ]] && OUTPUTDIR=.

[[ ! -d "$OUTPUTDIR" ]] && mkdir -p $OUTPUTDIR

echo "Writing $DIRECTORY/$BASENAME to $OUTPUTDIR/$FILENAME.xml"

mmark "$1" > $OUTPUTDIR/"$FILENAME.xml"

echo "Creating html from $OUTPUTDIR/$FILENAME.xml to $OUTPUTDIR/$FILENAME.html"

`which xml2rfc` --html $OUTPUTDIR/"$FILENAME.xml" -o $OUTPUTDIR/"$FILENAME.html"

if [[ $? != 0 ]]; then
	echo "Encountered error parsing xml2rfc, cleaning up"
	rm -f $OUTPUTDIR/"$FILENAME"*
	exit 0;
fi

echo "Creating txt from $OUTPUTDIR/$FILENAME.txt to $OUTPUTDIR/$FILENAME.txt"

`which xml2rfc` --text $OUTPUTDIR/"$FILENAME.xml" -o $OUTPUTDIR/"$FILENAME.txt"

