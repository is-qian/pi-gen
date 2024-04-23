#!/bin/bash -e
set -x
GIT_MODULE = 'http://192.168.1.77:1080/awesome-se/seeed-linux-dtoverlays.git -b master --depth=1'
SEEED_DEV_NAME = SEEED_DEV_NAME=reComputer-R100x

if [ "X$GIT_MODULE" != "X" ]; then
	MODULE_PATH=/tmp/seeed-linux-dtoverlays
	${PROXYCHAINS} git clone ${GIT_MODULE} "${ROOTFS_DIR}${MODULE_PATH}"
	${PROXYCHAINS} wget http://192.168.1.77/reTerminalDM/dt-blob-disp1-cam2.bin -O "${ROOTFS_DIR}/boot/dt-blob.bin"

	on_chroot << EOF
cd ${MODULE_PATH}
dpkg -l | grep kernel
./scripts/reTerminal.sh --device ${SEEED_DEV_NAME}
EOF

	rm -rfv "${ROOTFS_DIR}${MODULE_PATH}"
fi

if [ -f "packages" ]; then
	log "Begin ${SUB_STAGE_DIR}/packages"
	PACKAGES="$(sed -f "${SCRIPT_DIR}/remove-comments.sed" < "packages")"
	if [ -n "$PACKAGES" ]; then
		on_chroot << EOF
set -x
apt-get -o APT::Acquire::Retries=3 install -y $PACKAGES
EOF
		if [ "${USE_QCOW2}" = "1" ]; then
			on_chroot << EOF
apt-get clean
EOF
		fi
	fi
	log "End ${SUB_STAGE_DIR}/packages"
fi

if [ -f "purges" ]; then
	log "Begin ${SUB_STAGE_DIR}/purges"
	PACKAGES="$(sed -f "${SCRIPT_DIR}/remove-comments.sed" < "purges")"
	if [ -n "$PACKAGES" ]; then
		on_chroot << EOF
apt-get autoremove --purge -y $PACKAGES
EOF
		if [ "${USE_QCOW2}" = "1" ]; then
			on_chroot << EOF
apt-get clean
EOF
		fi
	fi
	log "End ${SUB_STAGE_DIR}/purges"
fi

if [ -f "python-packages" ]; then
	log "Begin ${SUB_STAGE_DIR}/python-packages"
	PACKAGES="$(sed -f "${SCRIPT_DIR}/remove-comments.sed" < "python-packages")"
	if [ -n "$PACKAGES" ]; then
		on_chroot << EOF
set -x
pip3 install $PACKAGES
EOF
	fi
	log "End ${SUB_STAGE_DIR}/python-packages"
fi

if [ -f "remove" ]; then
	log "Begin ${SUB_STAGE_DIR}/remove"
	PACKAGES="$(sed -f "${SCRIPT_DIR}/remove-comments.sed" < "remove")"
	on_chroot << EOF
rm -rfv $PACKAGES
EOF
	log "End ${SUB_STAGE_DIR}/remove"
fi


if [ "${COPY_FILES}" = "1" ]; then
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
