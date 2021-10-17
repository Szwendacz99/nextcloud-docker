FROM debian:stable-slim

USER root

# path of nextcloud web files folder
# this path need to be ending without slash
# remember to make volumes mounts use the same path
ENV BASE_DIR="/custom/path"
ENV NC_VERSION="22.2.0"
ENV TZ=Europe/Warsaw

RUN userdel -rf www-data && \
    useradd -u 1001 -m -s '/bin/bash' -U www-data

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt update &&\
    apt upgrade -y && \
    apt install -y \
    apache2 \
    libapache2-mod-fcgid \
    wget \
    unzip \
    libaugeas0 \
    libmagickcore-6.q16-6-extra

RUN wget https://download.nextcloud.com/server/releases/nextcloud-${NC_VERSION}.zip && \
    mv nextcloud-${NC_VERSION}.zip nextcloud.zip && \
    chown www-data.www-data nextcloud.zip && \
    chsh -s /bin/bash www-data

COPY root_hack.c /var/cache/root_hack.c

# compile here instead of copying ready file, so it will be 
# compatible with any cpu architecture when deploying
RUN apt install -y gcc && \
    gcc /var/cache/root_hack.c -o /usr/bin/root_hack && \
    apt -y purge gcc && \
    apt -y autoremove && \
    apt -y clean

COPY nextcloud.conf /etc/apache2/sites-available/nextcloud.conf
COPY envvars /etc/apache2/envvars
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY start_script_root.sh /usr/bin/start_script_root.sh
COPY apache2.conf /etc/apache2/apache2.conf

RUN chown www-data.www-data /usr/bin/entrypoint.sh && \
    chmod +x /usr/bin/entrypoint.sh && \
    chown root.root /usr/bin/root_hack && \
    chmod 4755 /usr/bin/root_hack

RUN a2ensite nextcloud.conf && \
    a2dissite 000-default && \
    a2enmod rewrite && \
    a2enmod headers && \
    a2enmod env && \
    a2enmod dir && \
    a2enmod mime && \
    a2enmod ssl && \
    a2enmod http2 && \
    a2dismod mpm_prefork && \
    a2enmod mpm_event && \
    a2enmod proxy_fcgi && \
    a2enmod setenvif 

RUN chown -R www-data.www-data /etc/apache2

USER www-data

STOPSIGNAL SIGWINCH

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
