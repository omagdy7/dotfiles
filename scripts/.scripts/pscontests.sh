#!/bin/bash

echo -n "Contest Name? : "
read
PROBLEMS="A B C D E F"
mkdir ${REPLY}
cd ${REPLY}
for p in $PROBLEMS
do
  touch $p.cpp
  echo -e "#include<bits/stdc++.h>\n\nusing namespace; std\n\nint main () {ios_base::sync_with_stdio(false);\ncin.tie(NULL);\nint tt;\nwhile(tt--){\n}}" > $p.cpp
done
