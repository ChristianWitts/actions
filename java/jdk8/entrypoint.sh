#!/bin/sh
set -e

cd "${JDK_ACTION_WORKING_DIR:-.}"

GRADLE_TASK=${GRADLE_ACTION_TASK:-build}

set +e
WARNINGS=$(./gradlew "${GRADLE_TASK}" 2>&1)
SUCCESS=$?
echo "$WARNINGS"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

if [ "$GRADLE_ACTION_COMMENT" = "1" ] || [ "$GRADLE_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

WARNINGS=$(echo "${WARNINGS}" | sed -n -e '/FAILURE/,/* Try/p' | sed -n -e '/* Try/!p')

COMMENT="#### \`gradle\` Failed
##### Task: $GRADLE_TASK
$WARNINGS
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(jq -r .pull_request.comments_url /github/workflow/event.json)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

if [ -z "${ACTION_FAILURE_CODE}" ]; then
  exit "$SUCCESS"
fi

exit "$ACTION_FAILURE_CODE"
