FROM jenkins/jenkins:latest
ARG DOCKER_GROUP_ID

USER root

WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk

RUN curl -o /root/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-1.12.5.tgz && tar -C /root -xvf /root/docker.tgz && mv /root/docker/docker /usr/local/bin/docker && rm -rf /root/docker*
RUN curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN groupadd -g $DOCKER_GROUP_ID docker && gpasswd -a jenkins docker

RUN mkdir android-sdk && wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip && \
  unzip commandlinetools-linux-6609375_latest.zip -d $ANDROID_HOME && \
  rm commandlinetools-linux-6609375_latest.zip
COPY licenses $ANDROID_HOME/licenses
RUN chown -R jenkins:jenkins android-sdk

USER jenkins

RUN $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;30.0.2"
