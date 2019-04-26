FROM python:3-slim-stretch

LABEL "com.github.action.name"="Ansible test"
LABEL "com.github.action.description"="Runs `molecule` to test the playbook"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/actions"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

RUN pip install molecule

ENTRYPOINT ["/entrypoint.sh"]

