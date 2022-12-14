# SuiteCRM
FROM ubuntu:21.04 as suitecrm-server
ARG DEBIAN_FRONTEND=noninteractive
EXPOSE 80
RUN sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# Install Apache & Utilities
RUN echo "Installing Apache & Utilities..."
RUN apt-get update && apt-get upgrade -y && apt-get install -y apache2 
RUN apt-get install -y software-properties-common gcc wget curl unzip composer

# Install PHP
RUN echo "Installing PHP & PHP Libraries..."
RUN apt-get install -yqq php7.4 php7.4-imagick php7.4-fpm php7.4-mysql php7.4-common php7.4-gd php7.4-imap php7.4-json php7.4-curl php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-gmp libapache2-mod-php7.4

# Install and configure MariaDB
RUN echo "Installing MariaDB Server..."
RUN apt-get install -y mariadb-server expect

WORKDIR /
COPY install_suitecrm.sh config_si.php configure_mariadb.sh init_db.sh ./
RUN chmod +x ./install_suitecrm.sh ./config_si.php ./configure_mariadb.sh ./init_db.sh

# Set up MariaDB for SuiteCRM
RUN echo "Configuring MariaDB..."
RUN ./configure_mariadb.sh
RUN echo "Adding DB & USER in MariaDB for SuiteCRM..."
RUN ./init_db.sh

# Install and configure SuiteCRM & Composer
RUN echo "Installing SuiteCRM & Composer..."
RUN ./install_suitecrm.sh

ENTRYPOINT /etc/init.d/mariadb start && /etc/init.d/apache2 start && curl "http://127.0.0.1/suitecrm/install.php?goto=SilentInstall&cli=true" > /dev/null 2>&1 && echo "Visit http://<IP_Address/suitecrm to login" && bash
