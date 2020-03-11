#!/bin/bash

FILENAME=`grep -m1 value $1 | cut -d'"' -f2`

mmark $1 > $FILENAME.xml

`which xml2rfc` --html $FILENAME.xml 

`which xml2rfc` --text $FILENAME.xml

