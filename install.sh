#!/bin/bash
set -u

abort() {
  printf "%s\n" "$1"
  exit 1
}

# First check OS.
OS="$(uname)"
if [[ "$OS" == "Linux" ]]; then
  INSTALL_ON_LINUX=1
else
  abort "container-debug is only supported on Linux."
fi

if which apk; then
  PACKAGE_MANAGER=apk
elif which apt-get; then
  PACKAGE_MANAGER=apt-get
elif which yum; then
  PACKAGE_MANAGER=yum
else
  abort "container-debug did not find apk, apt-get or yum."
fi

