#!/bin/bash -e
set -x

SEEED_DEV_NAME=${IMG_NAME}
GIT_MODULE='https://github.com/Seeed-Studio/seeed-linux-dtoverlays.git -b master --depth=1'


ls -l
#如果存在files文件夹，则执行
if [ -f "files"]; then
	log "Begin copy files special for seeed"
	chmod +x ./files/dsi_fix.sh
	cp ./files/dsi_fix.sh ${ROOTFS_DIR}/var/
	cp ./files/seeed_dsifix.service ${ROOTFS_DIR}/lib/systemd/system/
	on_chroot << EOF
systemctl daemon-reload
systemctl enable seeed_dsifix.service
EOF
	log "End copy files special for seeed"
fi

if [ "${COPY_DOCKER_IMG}" = "1" ]; then
	if [ -d $BASE_DIR/docker_images ]; then
		cp -r $BASE_DIR/docker_images "${ROOTFS_DIR}/var/"
	else
		log "docker image files not exist,check your CI code!"
	fi
fi
