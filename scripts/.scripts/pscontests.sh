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
  touch main.cpp
  echo -e "#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main () {\n\tios_base::sync_with_stdio(false);\n\tcin.tie(NULL);\n\tint tt;\n\tcin >> tt;\n\twhile(tt--){\n\n\t}\n}" > main.cpp
  touch inp
  cd ..
done
