#!/usr/bin/env bash

# mkfatimg.sh
# A simple script to quickly create FAT floppy disk images
#
# Author: Josh Mast <josh@mast.zone>
# URL: https://github.com/kaiju/mkfatimg

mformatargs=("-f" "1440" "-C" "-i")

while getopts ":F" flags
do
  case $flags in
    F) mformatargs=("-F" "${mformatargs[@]}");;
    *) ;;
  esac
done
shift $((OPTIND - 1))

if [[ $# -lt 2 ]]; then
  echo "Usage: $(basename "$0") [-F] [disk image] [files ...]"
  echo ""
  echo "Positional Arguments:"
  echo -e "   disk image\t\tDisk image to create"
  echo -e "   files ...\t\tFiles to add to the disk image. If this is a single zip file, the contents of the zip file will be added to the disk image."
  echo ""
  echo "Options:"
  echo -e "   -F\t\tCreate a FAT32 disk image"
  exit 85
fi

image_file=$1
mformatargs+=("$image_file")
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

mformat "${mformatargs[@]}"
mcopy -i "$image_file" -s -v "${files[@]}" ::

# Cleanup
if [[ -n $zip_file ]]; then
  rm -rf "/tmp/$zip_filename"
fi

