NAME =			owncloud
VERSION =		latest
VERSION_ALIASES =	9.1.0
TITLE =			ownCloud
DESCRIPTION =		ownCloud
DOC_URL =		https://www.scaleway.com/docs/deploy-owncloud-with-object-storage
SOURCE_URL =		https://github.com/scaleway-community/scaleway-owncloud
VENDOR_URL =		https://owncloud.org
DEFAULT_IMAGE_ARCH =	x86_64


IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT = latest
IMAGE_NAME =		Owncloud 9.1


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
