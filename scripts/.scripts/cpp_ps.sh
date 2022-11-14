#!/bin/sh
echo -e "Are you sure? y)es n)o"
read input
if [ "$input" = "y" ]; then
  mkdir $1
  cd $1
  cp ~/test/cptemplate/main.cpp .
  nvim main.cpp
fi



