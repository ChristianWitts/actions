FROM centos:7

LABEL "com.github.action.name"="Ansible test"
LABEL "com.github.action.description"="Runs `molecule` to test the playbook"
LABEL "com.github.actions.lock"="lock"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ChristianWitts/actions"
LABEL "homepage"="https://github.com/ChristianWitts/actions/actions"
LABEL "maintainer"="Christian Witts <cwitts@gmail.com>"

RUN yum group install -y "Development Tools" python-devel \
 && curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" \
 && python get-pip.py \
 && pip install molecule --prefer-binary

ENTRYPOINT ["/entrypoint.sh"]

