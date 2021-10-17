#!/bin/bash


# path of nextcloud web files folder
# this path need to be ending without slash
# remember to make volumes mounts use the same path
BASE_DIR="/custom/path"

if ! [ "$USER" = "root" ]; then
    echo "Script must be run as root, exiting..."
    exit 1
fi

mkdir -p $BASE_DIR/web/mysql $BASE_DIR/web/nextcloud $BASE_DIR/web/redis $BASE_DIR/data $BASE_DIR/web/ssl
chmod 100 $BASE_DIR/web
chmod 700 $BASE_DIR/web/mysql $BASE_DIR/web/nextcloud $BASE_DIR/web/redis $BASE_DIR/data $BASE_DIR/web/ssl
