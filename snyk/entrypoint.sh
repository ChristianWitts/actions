#!/bin/sh
set -e

cd "${SNYK_ACTION_WORKING_DIR:-.}"

if [ -z "$SNYK_API_TOKEN" ]; then
    exit 1
fi

snyk auth "${SNYK_API_TOKEN}"

set +e
WARNINGS=$(snyk test)
SUCCESS=$?
echo "$WARNINGS"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

if [ "$SNYK_ACTION_COMMENT" = "1" ] || [ "$SNYK_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

COMMENT="#### \`snyk\` Failed
$WARNINGS
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(jq -r .pull_request.comments_url /github/workflow/event.json)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS

