#!/bin/bash

echo "Running As: $(whoami):$(id -gn)"

mkdir -p /tmp/log/apache2/ /tmp/apache2/
chown -R www-data:www-data /var/lib/php/sessions /tmp/log/apache2/ /ssl /var/lib/apache2/fcgid /tmp/apache2/
chown www-data:www-data "$BASE_DIR" "$BASE_DIR"/data
