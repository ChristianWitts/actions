FROM python:3.7-alpine

LABEL "com.github.action.name"="truffleHog sniff"
LABEL "com.github.action.description"="Runs `truffleHog` to check for secrets being commited"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/truffleHog"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

WORKDIR /src

RUN apk add --no-cache git \
 && pip install truffleHog

ENTRYPOINT ["trufflehog", "."]

