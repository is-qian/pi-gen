#!/bin/bash -e
MODULE_PATH=/tmp/seeed-linux-dtoverlays
apt-get update
apt-get -y install dialog coreutils quilt parted qemu-user-static debootstrap zerofree zip dosfstools libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc qemu-utils kpartx gpg pigz xxd kmod binfmt-support
git clone https://github.com/Seeed-Studio/seeed-linux-dtoverlays.git -b master --depth=1 -O "${ROOTFS_DIR}${MODULE_PATH}"
ls -l
pwd
find / -name "0001-compatible-for-pi-gen.patch"
cp /home/runner/work/pi-gen/pi-gen/stage4a/package-test/0001-compatible-for-pi-gen.patch "${ROOTFS_DIR}${MODULE_PATH}"
cd ${MODULE_PATH}
ls -l
git apply 0001-compatible-for-pi-gen.patch
./scripts/reTerminal.sh --device reComputer-R100x --keep-kernel 
