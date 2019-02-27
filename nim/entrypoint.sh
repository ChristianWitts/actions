#!/bin/sh
set -e

cd "${NIM_ACTION_WORKING_DIR:-.}"

COMMAND=${NIM_ACTION_COMMAND:-test}
CHANNEL=${NIM_ACTION_CHANNEL:-stable}

choosenim "$CHANNEL"

set +e
WARNINGS=$(nimble "$COMMAND" 2>&1)
SUCCESS=$?
echo "$WARNINGS"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

if [ "$NIM_ACTION_COMMENT" = "1" ] || [ "$NIM_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

COMMENT="#### \`nimble ${COMMAND}\` Failed
$WARNINGS
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(jq -r .pull_request.comments_url /github/workflow/event.json)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS

