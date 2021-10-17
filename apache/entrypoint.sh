#!/bin/bash

# start C program that run scripts with jobs that need root perms
/usr/bin/root_hack

INSTALL_CHECK_FILE="version.php"

if ! [ -f "$BASE_DIR/$INSTALL_CHECK_FILE" ]; then
    echo "Installing nextcloud to $BASE_DIR ...."
    # exit 1
    unzip -q -d "$BASE_DIR" nextcloud.zip
    mv $BASE_DIR/nextcloud/* $BASE_DIR
    mv $BASE_DIR/nextcloud/.* $BASE_DIR
    rm -r "$BASE_DIR/nextcloud/"

    chown -R www-data:www-data "$BASE_DIR"
    echo "Installation complete!"
fi

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
