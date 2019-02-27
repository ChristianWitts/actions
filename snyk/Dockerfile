FROM node:10-alpine

LABEL "com.github.action.name"="snyk scan"
LABEL "com.github.action.description"="Runs `snyk` to check for vulnerabilities"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/snyk"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

WORKDIR /src

RUN apk add --no-cache jq curl \
 && npm install -g synk

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

