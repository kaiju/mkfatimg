#!/usr/bin/env bash

# mkfatimg.sh
# A simple script to quickly create FAT floppy disk images
#
# Author: Josh Mast <josh@mast.zone>
# URL: https://github.com/kaiju/mkfatimg

if [[ $2 == "" ]]; then
  echo "Usage: $(basename "$0") <disk image> <zip file|files...>"
  exit 85
fi

image_file=$1
shift

if [[ $# == 1 && "$(file -b --mime-type "$1")" == "application/zip" ]]; then
  zip_file=$1
  zip_filename=$(basename "$zip_file")
  mkdir -p "/tmp/$zip_filename"
  unzip -q -d "/tmp/$zip_filename" "$zip_file"
  files=(/tmp/"$zip_filename"/*)
else
  files=("$@")
fi

dd if=/dev/zero of="$image_file" bs=512 count=2880 status=none
mformat -f 1440 -F -i "$image_file" 
mcopy -i "$image_file" -s -v "${files[@]}" ::

# Cleanup
if [[ -n $zip_file ]]; then
  rm -rf "/tmp/$zip_filename"
fi

