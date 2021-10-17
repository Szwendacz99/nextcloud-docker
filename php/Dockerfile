FROM debian:stable-slim

USER root

# path of nextcloud web files folder
# this path need to be ending without slash
# remember to make volumes mounts use the same path
ENV BASE_DIR="/custom/path"
ENV TZ=Europe/Warsaw
ENV PHP_VERSION="7.4"

RUN useradd -u 1001 -m -s '/bin/bash' -U php

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt update && \
    apt upgrade -y && \
    apt install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-iconv \
    php-json \
    libxml2 \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring \
    openssl \
    php${PHP_VERSION}-posix \
    php${PHP_VERSION}-simplexml \
    php${PHP_VERSION}-xmlreader \
    php${PHP_VERSION}-xmlwriter \
    php${PHP_VERSION}-zip \
    zlib1g \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-bz2 \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-ftp \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-gmp \
    php${PHP_VERSION}-exif \
    php-redis \
    php-imagick \
    ffmpeg \
    php${PHP_VERSION}-phar \
    cron \
    libaugeas0 \
    libmagickcore-6.q16-6-extra

COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY root_hack.c /var/cache/root_hack.c
COPY start_script_root.sh /usr/bin/start_script_root.sh

RUN apt install -y gcc && \
    gcc /var/cache/root_hack.c -o /usr/bin/root_hack && \
    apt -y purge gcc && \
    apt -y autoremove && \
    apt -y clean

RUN { \
    echo "env[HOSTNAME] = php" ; \
    echo "env[PATH] = /usr/local/bin:/usr/bin:/bin" ; \
    echo "env[TMP] = /tmp" ; \
    echo "env[TMPDIR] = /tmp" ; \
    echo "env[TEMP] = /tmp" ; \
    echo "listen = 9000" ; \
    echo "pm = dynamic" ; \
    echo "pm.max_children = 120" ; \
    echo "pm.start_servers = 35" ; \
    echo "pm.min_spare_servers = 35" ; \
    echo "pm.max_spare_servers = 50" ; \
    } >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN { \
    echo "upload_max_filesize 2G" ; \
    echo "post_max_size = 2G" ; \
    echo "max_input_time = 30" ; \
    echo "max_execution_time = 30" ; \
    echo "memory_limit = 1024M" ; \
    \
    echo 'opcache.enable=1'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=10000'; \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.save_comments=1'; \
    echo 'opcache.revalidate_freq=1'; \
    } >> /etc/php/${PHP_VERSION}/fpm/php.ini

# this way, because php-fpm don't like specyfying the same setting twice
RUN sed -i 's/^error_log =.*/error_log = \/dev\/stderr/g' /etc/php/7.4/fpm/php-fpm.conf && \
    sed -i 's/^pid =.*/pid = \/tmp\/php7.4-fpm.pid/g' /etc/php/7.4/fpm/php-fpm.conf

RUN chown php.php /usr/bin/entrypoint.sh && \
    chmod +x /usr/bin/entrypoint.sh && \
    chown root.root /usr/bin/root_hack && \
    chmod 4755 /usr/bin/root_hack

RUN ln -sf /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm

RUN chown -R php.php /var/lib/php

# if changing custom path for nextcloud files, remember to change it here too
RUN echo "*/5  *  *  *  * php php -f ${BASE_DIR}/cron.php || echo 'ERROR Cron job with cron.php FAILED' | wall" >> /etc/crontab && \
    echo "#" >> /etc/crontab 

USER php

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
