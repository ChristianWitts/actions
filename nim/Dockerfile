FROM ubuntu:latest

LABEL "com.github.action.name"="Nim Test & Build"
LABEL "com.github.action.description"="Runs `nimble $COMMAND`"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/nim"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

ENV CHOOSENIM_NO_ANALYTICS=1

RUN apt-get update \
 && apt-get install curl gcc jq xz-utils\
 && curl https://nim-lang.org/choosenim/init.sh -sSf > /tmp/init.sh \
 && sh init.sh -y \
 && echo "export PATH=~/.nimble/bin:$PATH >> ~/.profile"

ENV PATH=~/.nimble/bin:$PATH

WORKDIR /src

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
