FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive
EXPOSE 80
RUN sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update > /dev/null 2>&1
RUN apt-get -y install openssl > /dev/null 2>&1
WORKDIR /
COPY init_mysql.sh init_db.sh init_suitecrm.sh config_si.php ./
RUN chmod +x ./init_mysql.sh ./init_db.sh ./init_suitecrm.sh
RUN ./init_mysql.sh && ./init_db.sh && ./init_suitecrm.sh
RUN rm ./init_mysql.sh ./init_db.sh ./init_suitecrm.sh ./v7.11.15.zip
ENTRYPOINT /etc/init.d/mariadb start && /etc/init.d/apache2 start && curl "http://127.0.0.1/suitecrm/install.php?goto=SilentInstall&cli=true" > /dev/null 2>&1 && echo "Visit http://<IP_Address/suitecrm to login" && bash