# Nim

Runs nimble `$command` on your project.

```
workflow "Nim" {
  resolves = ["nim-stable-test", "nim-head-test"]
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "nim-stable-refresh" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "refresh"
    NIM_ACTION_CHANNEL = "stable"
  }
}

action "nim-stable-check" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "nim-stable-refresh"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "check"
    NIM_ACTION_CHANNEL = "stable"
  }
}

action "nim-stable-test" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "nim-stable-check"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "test"
    NIM_ACTION_CHANNEL = "stable"
  }
}

action "nim-head-refresh" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "refresh"
    NIM_ACTION_CHANNEL = "#HEAD"
  }
}

action "nim-head-check" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "nim-head-refresh"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "check"
    NIM_ACTION_CHANNEL = "#HEAD"
  }
}

action "nim-head-test" {
  uses = "ChristianWitts/actions/nim@master"
  needs = "nim-head-check"
  secrets = ["GITHUB_TOKEN"]
  env = {
    NIM_ACTION_COMMAND = "test"
    NIM_ACTION_CHANNEL = "#HEAD"
  }
}
```
