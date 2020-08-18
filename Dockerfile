FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update -y && apt-get upgrade -y

RUN echo "Etc/UTC" > /etc/timezone

RUN apt-get install -y --fix-missing wget curl gnupg git file apt-utils nano zip unzip build-essential openssh-client rsync sudo snapd apt-transport-https openjdk-8-jre openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin
RUN java -version
# Download & Install Node JS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update -y && apt-get install -y nodejs && \
    npm install -g @angular/cli

# Download & Install Firebase CLI
RUN curl -sL https://firebase.tools | bash

# Download & Install Android SDK
ENV SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip" \
    ANDROID_HOME="/usr/local/android-sdk" \
    ANDROID_VERSION=29 \
    ANDROID_BUILD_TOOLS_VERSION=29.0.2 \
    REPO_OS_OVERRIDE=linux
# Download Android SDK
RUN mkdir "$ANDROID_HOME" .android \
    && mkdir "$ANDROID_HOME/cmdline-tools" \
    && cd "$ANDROID_HOME/cmdline-tools" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && mkdir "$ANDROID_HOME/licenses" || true \
    && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "$ANDROID_HOME/licenses/android-sdk-license" \
    && yes | $ANDROID_HOME/cmdline-tools/tools/bin/sdkmanager --licenses
# Install Android Build Tool and Libraries
RUN $ANDROID_HOME/cmdline-tools/tools/bin/sdkmanager --update
RUN $ANDROID_HOME/cmdline-tools/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools"

# Install flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1
ENV PATH="/flutter/bin:${PATH}"
RUN yes | flutter doctor --android-licenses && flutter doctor