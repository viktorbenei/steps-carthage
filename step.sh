#!/bin/bash

set -e

NO_USE_BINARIES=""
VERBOSE_MODE=""

if [[ "${no_use_binaries}" == "true" ]] ; then
	NO_USE_BINARIES='--no-use-binaries'
fi

if [[ "${verbose_output}" == "true" ]] ; then
	VERBOSE_MODE='--verbose'
fi

if [[ "${carthage_version}" == "0.9.4" ]] ; then
	curl -OlL "https://github.com/Carthage/Carthage/releases/download/0.9.4/Carthage.pkg"
	sudo installer -pkg "Carthage.pkg" -target /
	rm "Carthage.pkg"
else
	brew update && brew install carthage
fi

if [ ! -z "${working_dir}" ] ; then
	debug_echo "==> Switching to working directory: ${working_dir}"
	cd "${working_dir}"
	if [ $? -ne 0 ] ; then
		echo " [!] Failed to switch to working directory: ${working_dir}"
		exit 1
	fi
fi

#
# Bootstrap
carthage "${carthage_command}" --platform iOS ${NO_USE_BINARIES} ${VERBOSE_MODE}
