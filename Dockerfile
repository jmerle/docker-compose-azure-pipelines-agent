FROM ubuntu:16.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl3 \
        libicu55 \
        libunwind8 \
        netcat \
        zip \
        unzip \
        build-essential \
        cmake

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs \
        yarn

ENV SDKMAN_DIR /usr/local/sdkman

RUN curl -s get.sdkman.io | bash
RUN echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config

RUN source "$SDKMAN_DIR/bin/sdkman-init.sh" \
    && sdk install java 8.0.202-zulufx \
    && sdk install java 11.0.2-zulufx \
    && sdk install kotlin 1.3.50 \
    && sdk install gradle 5.6 \
    && sdk install maven 3.6.1

ENV JAVA_HOME_8_X64 $SDKMAN_DIR/candidates/java/8.0.202-zulufx/
ENV JAVA_HOME_11_X64 $SDKMAN_DIR/candidates/java/11.0.2-zulufx/

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
