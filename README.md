# deb-modifier
automated scripts to assist with modifying .deb packages

## extract.sh
### usage: `./extract.sh <exact package name>`
This won't run if files already exist in a folder matching the package name, or if the package name is not found in the current apt sources.
Current, original files are extracted to `<name>/original/` and left for reference. The files you should modify are in `<name>/output/`.

## compact.sh
### usage: `./compact.sh <name>`
This packs the files from `<name>/output/` into a .deb package at `<name>/output/out.deb`
