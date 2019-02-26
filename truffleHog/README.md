# Trufflehog

Runs trufflehog on your source code.

```
workflow "Trufflehog" {
  resolves = "trufflehog"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "trufflehog" {
  uses = "ChristianWitts/actions/trufflehog@master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TH_ACTION_WORKING_DIR = "."
  }
}
```
