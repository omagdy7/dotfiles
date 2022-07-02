#!/bin/sh

path="$HOME/.scripts"
command=$(ls $path | dmenu -l 5)
$path/$command

