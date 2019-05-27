FROM debian:stable-slim

LABEL "com.github.action.name"="diff_root"
LABEL "com.github.action.description"="Finds the root of your changes"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/diff_root"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        jq git && \
	apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/bin:${PATH}"

COPY bin /usr/local/bin/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
