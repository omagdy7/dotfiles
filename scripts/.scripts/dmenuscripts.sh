#!/bin/sh

path="/home/peng/.scripts"
command=$(ls $path | dmenu -l 5)
$path/$command

