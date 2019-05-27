# diff_root

Runs `git --no-pager diff --name-only FETCH_HEAD` to set an environment variable to be consumed by other actions.

```
action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "diff-root" {
  uses = "ChristianWitts/actions/diff_root@master"
  needs = "filter-to-pr-open-synced"
  args = "filter 'terraform'"
  secrets = ["GITHUB_TOKEN"]
  env = {
    ACTION_WORKING_DIR = "."
    VAR_TO_SET = "UPSTREAM_ENV_VAR"
  }
}
```
