# Dockerfile for Swift on Ubuntu 15.10

## Usage

```
git clone git@github.com:fromkk/dockerfile_swift_ubuntu.git
cd ./dockerfile_swift_ubuntu
docker build -t ubuntu:ubuntu_swift .
docker run -p 8090:8090 -it --privileged ubuntu:ubuntu_swift /bin/bash
```
