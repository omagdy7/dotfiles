#!/bin/sh

echo -e "Are you sure? y)es n)o"
read input
if [ "$input" = 'y' ]; then
  touch $1.cpp
  echo -e "#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main () {\n}" > $1.cpp
  nvim $1.cpp
fi



