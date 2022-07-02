#!/bin/sh

touch $1.cpp
echo -e "#include<bits/stdc++.h>\n\nusing namespace std;\n\nint main () {\n}" > $1.cpp
nvim $1.cpp



