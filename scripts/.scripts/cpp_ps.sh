#!/bin/sh
echo -e "Are you sure? y)es n)o"
read input
if [ "$input" = "y" ]; then
  mkdir $1
  cd $1
  touch main.cpp
  echo -e "#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main () {\n\tios_base::sync_with_stdio(false);\n\tcin.tie(NULL);\n\tint tt;\n\tcin >> tt;\n\twhile(tt--){\n\n\t}\n}" > main.cpp
  nvim main.cpp
fi



