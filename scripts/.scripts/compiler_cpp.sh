#!/bin/bash
NOCPP=$(echo $1 | sed "s/\.cpp//")
g++ $1 -o $NOCPP.o
./$NOCPP.o

