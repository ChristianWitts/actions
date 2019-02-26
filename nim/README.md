# Nim

Runs nimble `$command` on your project.

```
workflow "Nim" {
  resolves = "nim_test"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "nim-refresh" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "refresh"
    NIM_ACTION_CHANNEL = "stable"
  }
}

action "nim-check" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "nim-refresh"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "check"
    NIM_ACTION_CHANNEL = "stable"
  }
}

action "nim_test" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "nim-check"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "test"
    NIM_ACTION_CHANNEL = "stable"
  }
}
```
