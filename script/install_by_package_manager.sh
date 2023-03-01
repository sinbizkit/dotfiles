#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "Please use this script like:"
	echo "${0##*/} one_app"
	echo "${0##*/} curl wget firefox"
	exit 1
fi

# TODO: detect a package manager
pm=apt

if ! [[ -x "$(command -v $pm)" ]]; then
	>&2 echo "The package manager \`$pm\` isn't found. Please update this script \`${0##*/}\`."
	>&2 echo "Error occured. Exit"
	exit 1
fi

for app in $@; do
	sudo $pm install $app
	if [[ $? -ne 0 ]]; then
		>&2 echo "The installation for \`$app\` has been interrupted."
		>&2 echo "Error occured ($?). Exit"
		exit 1
	fi
done

exit 0
