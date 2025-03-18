#!/bin/bash -e
set -x

uname -r
ls -l /lib/modules/

kernelver=$(uname -r)

git clone https://github.com/hailo-ai/hailort-drivers.git
cd hailort-drivers/linux/pcie

make install_dkms

cd ../..

if [ -f "./download_firmware.sh" ]; then
    chmod +x ./download_firmware.sh
    ./download_firmware.sh
    mkdir -p /lib/firmware/hailo
    mv hailo8_fw.4.*.bin /lib/firmware/hailo/hailo8_fw.bin
else
    echo "Warning: download_firmware.sh not found, skipping firmware installation"
fi

mkdir -p /etc/udev/rules.d
cp ./linux/pcie/51-hailo-udev.rules /etc/udev/rules.d/

rm -rf hailort-drivers