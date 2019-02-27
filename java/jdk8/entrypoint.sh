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

COMMENT="#### \`gradle\` Failed
$WARNINGS
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(jq -r .pull_request_comments_url /github/workflow/event.json)
cat /github/workflow/event.json
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS

