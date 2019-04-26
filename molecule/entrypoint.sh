#!/bin/sh
set -e

cd "${MOLECULE_ACTION_WORKING_DIR:-.}"


set +e
WARNINGS=$(molecule test)
SUCCESS=$?
echo "$WARNINGS"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

if [ "$MOLECULE_ACTION_COMMENT" = "1" ] || [ "$MOLECULE_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

COMMENT="#### \`molecule\` Failed
$WARNINGS
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(jq -r .pull_request.comments_url /github/workflow/event.json)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS

