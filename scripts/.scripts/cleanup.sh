#!/bin/sh

files=$(fd --extension cpp | sed 's/\.\///')

for file in $files
do
  tmp=$(echo $file | sed 's/.cpp//')
  mkdir $tmp
  mv $file $tmp
done

