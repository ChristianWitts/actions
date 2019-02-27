FROM openjdk:8u181-jdk-slim-stretch

LABEL "com.github.action.name"="Gradle run"
LABEL "com.github.action.description"="Runs `gradle` tasks as per your argument"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.icon" = "play"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/java/jdk8"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

WORKDIR /src

RUN apt-get update \
 && apt-get install jq curl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
