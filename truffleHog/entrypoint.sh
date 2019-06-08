#!/bin/sh
set -e

cd "${TH_ACTION_WORKING_DIR:-.}"

if [ -z "${TH_MAX_DEPTH}" ]; then
    EXTRA_ARGS="--max_depth 1000"
else
    if [ "$TH_MAX_DEPTH" = "all" ]; then
        EXTRA_ARGS=""
    else
        EXTRA_ARGS="--max_depth $TH_MAX_DEPTH"
    fi
fi

if [ ! -z "$TH_RULES" ]; then
    EXTRA_ARGS="$EXTRA_ARGS --rules $TH_RULES"
fi

ls -lt

set +e
WARNINGS=$(trufflehog "$EXTRA_ARGS" --regex --entropy False --repo_path . 2>&1)
SUCCESS=$?
echo "$WARNINGS"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

if [ "$TH_ACTION_COMMENT" = "1" ] || [ "$TH_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

COMMENT="#### \`trufflehog\` Failed
$WARNINGS
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(jq -r .pull_request.comments_url /github/workflow/event.json)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS
