FROM jenkins/jenkins:lts

USER root

WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk

RUN mkdir android-sdk
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
RUN unzip sdk-tools-linux-3859397.zip -d $ANDROID_HOME
RUN rm sdk-tools-linux-3859397.zip
COPY licenses android-sdk/licenses
RUN chown -R jenkins:jenkins android-sdk

USER jenkins

RUN echo $ANDROID_HOME
RUN android-sdk/tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;26.0.2"
