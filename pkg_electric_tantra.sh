#!/usr/bin/env bash

## This script will generate pkg-files.

## Dirs
DIR="$(pwd)"
PKGDIR="$DIR/electric-tantra"

## Packages
PKGS=($(ls $PKGDIR))

## Script Termination
exit_on_signal_SIGINT () {
    { printf "\n\n%s\n" "Script interrupted." 2>&1; echo; }
    exit 0
}

exit_on_signal_SIGTERM () {
    { printf "\n\n%s\n" "Script terminated." 2>&1; echo; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Delete previous packages
delete_pkg () {
	{ echo; cd $DIR/x86_64; }
	set -- $DIR/x86_64/${PKGS[0]}-*
	if [[ -f "$1" ]]; then
		for pkg in "${PKGS[@]}"; do
			{ echo "Deleting previous '${pkg}' .pkg file..."; rm -r ${pkg}-*; }
		done
	fi
}

# Build packages
build_pkgs () {
	{ echo "Building Packages - "; echo; }
	cd $PKGDIR
	for pkg in "${PKGS[@]}"; do
		echo "Building ${pkg}..."
		cd ${pkg} && makepkg -s && rm -rf pkg
		mv *.pkg.tar.zst $DIR/x86_64
		# Verify
		while true; do
			set -- $DIR/x86_64/$pkg-*
			if [[ -f "$1" ]]; then
				{ echo; echo "Package '${pkg}' generated successfully."; echo; }
				break
			else
				{ echo; echo "Failed to build '${pkg}', Exiting..." >&2; }
				{ echo; exit 1; }
			fi
		done
		cd $PKGDIR
	done	
}

# Setup repository
setup_repo () {
	repoargs=("-n -R electric-tantra.db.tar.gz *.pkg.tar.zst")
	{ echo "Setting up repository & updating database..."; echo; }
	{ cd $DIR/x86_64; rm -f electric-tantra.*; repo-add $repoargs; }
	{ echo; echo "Done!"; echo; }
}

delete_pkg
build_pkgs
setup_repo
