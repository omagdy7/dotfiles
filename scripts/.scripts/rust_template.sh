#!/bin/sh
echo -e "sure? y)es n)o d)on't open the file"
read input
if [ "$input" = "y" ]; then
	mkdir "$1"
	cd "$1" || exit
	cp ~/programming/rust-template/main.rs .
	cp ~/programming/rust-template/rust-project.json .
	nvim main.rs
fi
if [ "$input" = "d" ]; then
	mkdir "$1"
	cp ~/programming/rust-template/main.rs "$1"
	cp ~/programming/rust-template/rust-project.json .
fi
