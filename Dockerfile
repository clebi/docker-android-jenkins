FROM jenkins/jenkins:latest

USER root

WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk

RUN mkdir android-sdk && wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip && \
  unzip commandlinetools-linux-6200805_latest.zip -d $ANDROID_HOME && \
  rm commandlinetools-linux-6200805_latest.zip
COPY licenses $ANDROID_HOME/licenses
RUN chown -R jenkins:jenkins android-sdk

USER jenkins

RUN $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;29.0.3"
