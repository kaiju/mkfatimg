# mkfatimg

A simple script to quickly create FAT floppy disk images from a set of files for use with older PCs, emulators, Gotek floppy emulators, etc.

## Usage

`mkfatimg.sh <disk image> <zip file|files...>`

If a single zip file is passed as an argument the contents of the zip file will be added to the created disk image.

## Dependencies

- [unzip](https://infozip.sourceforge.net/)
- [mtools](https://www.gnu.org/software/mtools/)

## Nix

A Nix flake & derivation is provided for people with similar brainworms.

```
nix run github:kaiju/mkfatimg
```

