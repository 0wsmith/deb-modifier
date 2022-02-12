#!/bin/bash

if ! [ -d "$1" ]
then
	echo "$1 doesnt exist"
	exit 1
fi

pushd "$1"

	pushd output

		pushd data
			tar zcf ../data.tar.gz .
		popd

		pushd control
			tar zcf ../control.tar.gz .
		popd

		ar rcs out.deb debian-binary control.tar.gz data.tar.gz

	popd

popd
