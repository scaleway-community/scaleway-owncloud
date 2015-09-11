NAME =			owncloud
VERSION =		latest
VERSION_ALIASES =	8.0.4 8.0 8
TITLE =			ownCloud
DESCRIPTION =		ownCloud
DOC_URL =		https://www.scaleway.com/docs/deploy-owncloud-with-object-storage
SOURCE_URL =		https://github.com/scaleway-community/scaleway-owncloud
VENDOR_URL =		https://owncloud.org

IMAGE_VOLUME_SIZE =	150G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		Owncloud 8

## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
