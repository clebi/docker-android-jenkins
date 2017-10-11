FROM jenkins/jenkins:lts

USER root

WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk

RUN mkdir android-sdk && wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
  unzip sdk-tools-linux-3859397.zip -d $ANDROID_HOME && \
  rm sdk-tools-linux-3859397.zip
COPY licenses $ANDROID_HOME/licenses
RUN chown -R jenkins:jenkins android-sdk

USER jenkins

RUN $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;26.0.2"
