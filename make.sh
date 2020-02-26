#!/bin/bash

FILENAME=`echo $1 | cut -f1 -d'.'`

mmark $FILENAME.md | sed 's/<?rfc sortrefs="yes"?>/<?rfc sortrefs="yes"?><?rfc private="Draft"?>/' > $FILENAME.xml

`which xml2rfc` --html $FILENAME.xml 

`which xml2rfc` --text $FILENAME.xml
