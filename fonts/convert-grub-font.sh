#!/bin/bash
#
# Usage : $0 FONT SIZE

# filename : ${1##*/}
# filename without extension : ${1##*.}  OR ${1%%.*}
# ref : https://linuxhint.com/read_filename_without_extension_bash

[ ! -d ./output ] && mkdir output

if [ "$1" = "all" ] ; then
	for font in $(ls *.ttf *.ttc)
	do
		echo "$font"
		grub-mkfont --output="./output/${font%%.*}-16.pf2" --size=16 "$font"
		file ./output/${font%%.*}-16.pf2
		grub-mkfont --output="./output/${font%%.*}-18.pf2" --size=18 "$font"
		file ./output/${font%%.*}-18.pf2
		grub-mkfont --output="./output/${font%%.*}-22.pf2" --size=22 "$font"
		file ./output/${font%%.*}-22.pf2
		grub-mkfont --output="./output/${font%%.*}-24.pf2" --size=24 "$font"
		file ./output/${font%%.*}-24.pf2
	done

	exit
fi


if [ -z "$1" ] || [ -z "$2" ] ; then
	echo "Require font name and size. ex) $0 ./original.ttf 16" 
	exit
fi

grub-mkfont --output="./output/${1%%.*}-${2}.pf2" --size=$2 "$1"

if [ $? -eq 0 ] ; then
	echo "Output : $( realpath ./output/${1%%.*}-${2}.pf2 )"
	ls -al ./output
else
    echo "Failed."
fi

