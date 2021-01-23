#!/bin/sh
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


if [[ $PACKAGE_MANAGER == "apk" ]]; then
  apk update
  apk add curl vim procps net-tools lsof
elif [[ $PACKAGE_MANAGER == "apt-get" ]]; then
  apt-get update
  apt-get install -y curl vim procps inetutils-tools net-tools lsof
elif [[ $PACKAGE_MANAGER == "yum" ]]; then
  yum makecache
  yum install curl vim procps lsof
fi

sed -i 's/set mouse=a/set mouse=c/' /usr/share/vim/vim8*/defaults.vim

