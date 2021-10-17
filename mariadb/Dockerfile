FROM mariadb:10.6.3-focal

ENV TZ=Europe/Warsaw

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo $TZ > /etc/timezone

COPY custom.cnf /etc/mysql/mariadb.conf.d/custom.cnf
