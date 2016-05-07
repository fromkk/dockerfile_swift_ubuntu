FROM ubuntu:14.04
MAINTAINER Kazuya Ueoka <info@fromkk.info>

#initial settings
RUN apt-get update && \
    apt-get install -y build-essential wget clang libedit-dev python2.7 python2.7-dev libxml2 git curl make mysql-server libmysqlclient-dev libicu-dev

ADD mysql/charset.cnf /etc/mysql/conf.d/
RUN mysql_install_db
RUN chown -R mysql:mysql /var/lib/mysql
ADD mysql/startup.sh /startup.sh
RUN chmod 755 /startup.sh
RUN ./startup.sh

RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

#download swift
RUN wget https://swift.org/builds/development/ubuntu1404/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz && \
    wget https://swift.org/builds/development/ubuntu1404/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz.sig && \
    gpg --verify swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz.sig && \
    tar -xvzf swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz --directory / --strip-components=1

# Set Swift Path
ENV PATH /usr/bin:$PATH

# Print Installed Swift Version
RUN swift --version && \
    swift build --version

#RUN wget cli.qutheory.io -O vapor && \
#    chmod +x vapor && \
#    mv vapor /usr/local/bin && \
#    vapor help
