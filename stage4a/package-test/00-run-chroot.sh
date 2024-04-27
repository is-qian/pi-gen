#!/bin/bash
MODULE_PATH=/tmp/seeed-linux-dtoverlays
apt-get update
rpi-update
apt-get -y install dialog coreutils quilt parted qemu-user-static debootstrap zerofree zip dosfstools libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc qemu-utils kpartx gpg pigz xxd kmod binfmt-support
git clone https://github.com/Seeed-Studio/seeed-linux-dtoverlays.git -b master --depth=1
cd seeed-linux-dtoverlays
ls -l
./scripts/reTerminal.sh --device reComputer-R100x --keep-kernel 
