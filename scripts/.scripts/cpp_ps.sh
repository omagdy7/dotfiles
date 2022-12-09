#!/bin/sh
echo -e "sure? y)es n)o d)on't open the file"
read input
if [ "$input" = "y" ]; then
  mkdir $1
  cd $1
  cp ~/test/cptemplate/main.cpp .
  nvim main.cpp
fi
if [ "$input" = "d" ]; then
  mkdir $1
  cp ~/test/cptemplate/main.cpp $1 
fi


