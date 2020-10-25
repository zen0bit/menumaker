#!/bin/bash

# Extract menu descriptors from .deb files found in all directories
# rooted by command-line parameters and cat them to stdout
# Ex:> ./debian-menu-extract.sh /var/cache/apt > menu-file

shopt -s globstar

for root in $*; do
	for deb in $root/**/*.deb; do
		echo `basename "$deb"` 1>&2
		dest=`mktemp -d`
		dpkg-deb -x "$deb" $dest
		wc=$dest/usr/share/menu/*
		for menu in `echo $wc`; do
			if [ -f $menu ]; then
				cat $menu | sed -e '/^[ \t]*$/ d'
			fi
		done
		rm -rf $dest
	done
done

#
