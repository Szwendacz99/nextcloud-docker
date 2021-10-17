#!/bin/bash

# # start C program that run scripts with jobs that need root perms
/usr/bin/root_hack

exec php-fpm --nodaemonize
