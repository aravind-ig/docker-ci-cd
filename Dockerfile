FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update -y && apt-get upgrade -y

RUN echo "Etc/UTC" > /etc/timezone

RUN apt-get install -y wget curl gnupg git nano zip unzip software-properties-common build-essential openssh-client rsync sudo snapd apt-transport-https dart

RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update -y && apt-get install -y dart
RUN echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile
RUN which dart

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update -y && apt-get install -y nodejs && \
    npm install -g @angular/cli

RUN curl -sL https://firebase.tools | bash

RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1
RUN pwd
RUN echo 'export PATH=`pwd`/flutter/bin"' >> ~/.profile
RUN which flutter
RUN flutter precache