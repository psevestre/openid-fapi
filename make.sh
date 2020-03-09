#!/bin/bash

FILENAME=`echo $1 | cut -f1 -d'.'`

mmark $FILENAME.md > $FILENAME-1_0.xml

`which xml2rfc` --html $FILENAME-1_0.xml 

`which xml2rfc` --text $FILENAME-1_0.xml
