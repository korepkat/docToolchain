FROM openjdk:14-jdk-alpine

ENV LC_CTYPE en_US.UTF-8
ENV DTBranch main 
RUN addgroup -S dtcgroup && adduser -S dtcuser -G dtcgroup

RUN apk update && apk add --no-cache build-base

RUN	echo "add needed tools" && \
    apk add --no-cache curl wget zip unzip git bash --virtual build-dependencies build-base\
    git \
    graphviz \
    python \
    ruby-dev \
    py-pygments \
    libc6-compat \
    ttf-dejavu \
    doxygen
RUN gem update --system  --no-rdoc --no-ri
RUN gem install rdoc --no-document 
RUN gem install pygments.rb

SHELL ["/bin/bash", "-c"]

WORKDIR /home/dtcuser
ENV HOME=/home/dtcuser

ENV GRADLE_USER_HOME=/home/dtcuser/.gradle

RUN wget https://github.com/korepkat/docToolchain/archive/refs/heads/${DTBranch}.zip && \
    unzip ${DTBranch}.zip

RUN     ls . && \
        cd docToolchain-${DTBranch} && \
        rm -rf `find -type d -name .git` && \
        umask g+w && \
        ./gradlew tasks && \
        ./gradlew dependencies && \
        ./gradlew generatePDF && \
        chmod -R o=u $GRADLE_USER_HOME && \
        chmod -R g=u $GRADLE_USER_HOME && \
        rm -r $GRADLE_USER_HOME/daemon && \
        chmod -R o=u $HOME

ENV PATH="/home/dtcuser/docToolchain-${DTBranch}/bin:${PATH}"

USER dtcuser

WORKDIR /project

VOLUME /project

ENTRYPOINT /bin/bash