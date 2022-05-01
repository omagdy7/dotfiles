#!/bin/bash

echo -n "Contest Name? : "
read
PROBLEMS="A B C D E F"
mkdir ${REPLY}
cd ${REPLY}
for p in $PROBLEMS
do
  mkdir $p
  cd $p
  touch $p.cpp
  cd ..
done
cd ..
