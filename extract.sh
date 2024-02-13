#!/bin/bash

if [ -z "${1}" ]
then
	echo "Usage: $0 <package/basename>"
	exit 1
fi 

package="$(<<< "${1}" sed -e 's/\.deb$//')"

if [ -d "${package}_mod" ]
then
	echo "${package} was already extracted"
	exit 1
fi

mkdir "${package}_mod"

pushd "${package}_mod"

	mkdir output original original/data original/control

	pushd original

		if [ -f "../../${package}.deb" ]
		then
			cp "../../${package}.deb" .
		elif ! apt-get download "${package}"
		then
			echo "could not find ${package}"
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
