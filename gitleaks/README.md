# Gitleaks

Runs `gitleaks` on your source code.

```
workflow "Gitleaks" {
  resolves = "gitleaks"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "gitleaks" {
  uses = "ChristianWitts/actions/gitleaks@master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TH_ACTION_WORKING_DIR = "."
  }
}
```
