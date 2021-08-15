FROM openjdk:14-jdk-slim-buster

ENV SDKMAN_DIR=/root/.sdkman

ENV LC_CTYPE en_US.UTF-8

RUN	echo "add needed tools" && \
    apt-get update -y && \
    apt-get install -y curl wget zip unzip bash \
    git \
    graphviz \
    python \
    ruby \
    python-pygments \
    pandoc \
    pandoc-* \
    ttf-dejavu && \
    gem install rdoc --no-document && \
    gem install pygments.rb

SHELL ["/bin/bash", "-c"]

COPY . docToolchain

RUN     cd docToolchain && \
        rm -rf `find -type d -name .git` && \
        ./gradlew tasks && \
        ./gradlew && \
        PATH="/docToolchain/bin:${PATH}"

ENV PATH="/docToolchain/bin:${PATH}"

RUN mkdir /project

WORKDIR /project

VOLUME /project

ENTRYPOINT /bin/bash
