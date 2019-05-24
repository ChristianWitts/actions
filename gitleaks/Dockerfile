FROM zricethezav/gitleaks

LABEL "com.github.action.name"="gitleaks"
LABEL "com.github.action.description"="Runs `gitleaks` to check for secrets being commited"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/gitleaks"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

WORKDIR /src

ENTRYPOINT ["/entrypoint.sh"]
