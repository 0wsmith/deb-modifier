#!/bin/bash

if [ -z "${1}" ]
then
	echo "Usage: $0 <package/basename>"
	exit 1
fi 

package="$(<<< "${1}" sed -e 's/\.deb$//')"

if ! [ -d "${package}_mod" ]
then
	echo "${package} was not extracted"
	exit 1
fi

pushd "${package}_mod"

	pushd output

		newname="$(grep -oP 'Package: \K.+' control/control)"
		newvers="$(grep -oP 'Version: \K.+' control/control)"
		newarch="$(grep -oP 'Architecture: \K.+' control/control)"
		newfile="${newname}_${newvers}_${newarch}"

		pushd data
			for checksum in md5sum sha256sum sha512sum
			do
				find * -type f -exec "${checksum}" {} \; > "../control/${checksum}s"
			done
			tar zcf ../data.tar.gz .
		popd

		pushd control
			tar zcf ../control.tar.gz .
		popd

		ar rcs "${newfile}.deb" debian-binary control.* data.*

	popd

popd
