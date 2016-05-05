FROM ubuntu:15.10
MAINTAINER Kazuya Ueoka <info@fromkk.info>

#initial settings
RUN apt-get update && \
    apt-get install -y build-essential wget clang libedit-dev python2.7 python2.7-dev libxml2 git curl make  mariadb-server mariadb-client libmysqlclient-dev

RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

#download swift
RUN wget https://swift.org/builds/development/ubuntu1510/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu15.10.tar.gz && \
    wget https://swift.org/builds/development/ubuntu1510/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu15.10.tar.gz.sig && \
    gpg --verify swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu15.10.tar.gz.sig && \
    tar -xvzf swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu15.10.tar.gz --directory / --strip-components=1

# Set Swift Path
ENV PATH /usr/bin:$PATH

# Print Installed Swift Version
RUN swift --version && \
    swift build --version

#RUN wget cli.qutheory.io -O vapor && \
#    chmod +x vapor && \
#    mv vapor /usr/local/bin && \
#    vapor help
