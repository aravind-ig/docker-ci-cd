FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update -y && apt-get upgrade -y

RUN echo "Etc/UTC" > /etc/timezone

RUN apt-get install -y wget curl gnupg git nano zip unzip software-properties-common build-essential openssh-client rsync sudo snapd

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update -y && apt-get install -y nodejs && \
    npm install -g @angular/cli

RUN curl -sL https://firebase.tools | bash

RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1
RUN export PATH="$PATH:`pwd`/flutter/bin"
RUN flutter precache