NAME =			owncloud
VERSION =		latest
VERSION_ALIASES =	8.0.4 8.0 8
TITLE =			ownCloud
DESCRIPTION =		ownCloud
DOC_URL =		https://www.scaleway.com/docs/deploy-owncloud-with-object-storage
SOURCE_URL =		https://github.com/scaleway-community/scaleway-owncloud
VENDOR_URL =		https://owncloud.org
DEFAULT_IMAGE_ARCH =	x86_64


IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT = latest
IMAGE_NAME =		Owncloud 8


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - https://j.mp/scw-builder | bash
-include docker-rules.mk
