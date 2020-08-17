FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update -y && apt-get upgrade -y

RUN echo "Etc/UTC" > /etc/timezone

RUN apt-get install -y --fix-missing wget curl gnupg git nano zip unzip build-essential openssh-client rsync sudo snapd apt-transport-https
# RUN apt-get install -y --fix-missing android-sdk
# RUN echo $PATH 123

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update -y && apt-get install -y nodejs && \
    npm install -g @angular/cli
RUN curl -sL https://firebase.tools | bash

# RUN echo $PATH 1234

# install flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1
ENV PATH="/flutter/bin:${PATH}"
RUN yes | flutter doctor --android-licenses && flutter doctor