# Molecule

Runs `molecule test` on your source code.

```
workflow "Molecule" {
  resolves = "molecule-test"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "molecule-test" {
  uses = "ChristianWitts/actions/molecule@master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    MOLECULE_ACTION_WORKING_DIR = "."
  }
}
```

