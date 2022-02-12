#!/bin/bash

if [ -d "$1" ]
then
	echo "$1 already exists"
	exit 1
fi

mkdir "$1"

pushd "$1"

	mkdir output original original/data original/control

	pushd original
		if ! apt-get download "$1"
		then
			echo "could not find $1"
			exit 1
		fi
		ar x *.deb

		pushd control
			tar xf ../control.*
		popd

		pushd data
			tar xf ../data.*
		popd

		cp -r data ../output/
		cp -r control ../output/
		cp debian-binary ../output/

	popd

popd
