#!/bin/sh
set -e

cd "${TH_ACTION_WORKING_DIR:-.}"
FIRST_BRANCH_COMMIT=$(git rev-parse "$(git rev-parse --abbrev-ref HEAD)")
echo "Running up to ${FIRST_BRANCH_COMMIT}"

set +e
WARNINGS=$(gitleaks --commit-stop="${FIRST_BRANCH_COMMIT}" --repo_path=. 2>&1)
SUCCESS=$?
echo "$WARNINGS"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

if [ "$TH_ACTION_COMMENT" = "1" ] || [ "$TH_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

COMMENT="#### \`gitleaks\` Failed
$WARNINGS
"
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(jq -r .pull_request.comments_url /github/workflow/event.json)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS

