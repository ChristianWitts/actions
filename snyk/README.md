# Snyk

Runs `snyk` on your source code.

```
workflow "Snyk" {
  resolves = "snyk-test"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "snyk-test" {
  uses = "ChristianWitts/actions/snyk@master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN", "SNYK_API_TOKEN"]
  env = {
    SNYK_ACTION_WORKING_DIR = "."
  }
}
```
