# deb-modifier
automated scripts to assist with modifying .deb packages

## extract.sh
### usage: `./extract.sh <exact package name>`
- will not run if files already exist in a folder matching the package name.
- will fail if package name is not found in the current apt sources.


## compact.sh
### usage: `./compact.sh <folder name>`
