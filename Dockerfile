FROM ubuntu:14.04
MAINTAINER Kazuya Ueoka <info@fromkk.info>
EXPOSE 8090

RUN apt-get update && \
    apt-get install -y build-essential wget clang libicu-dev libedit-dev python2.7 python2.7-dev libxml2 git curl make mysql-server libmysqlclient-dev vim sysv-rc-conf

ADD mysql/charset.cnf /etc/mysql/conf.d/
RUN mysql_install_db
RUN chown -R mysql:mysql /var/lib/mysql
RUN sysv-rc-conf mysql on
RUN service mysql start && mysqladmin -u root password 'password'

RUN wget https://swift.org/builds/development/ubuntu1404/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz && \
    wget https://swift.org/builds/development/ubuntu1404/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz.sig && \
    wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift && \
    gpg --verify swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz.sig && \
    tar xzf swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz --directory / --strip-components=1

ENV PATH /usr/bin:$PATH

# Print Installed Swift Version
RUN swift --version && \
    swift build --version

RUN mkdir /usr/share/swift/SwiftBBS
ADD base/Package.swift /usr/share/swift/SwiftBBS/Package.swift
RUN cd /usr/share/swift/SwiftBBS && swift build
