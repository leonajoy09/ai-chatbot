# Adding Static Application Security Testing (SAST) to Typescript Projects

## Semgrep
Semgrep is a fast, open-source, static analysis tool that finds bugs and enforces code standards at editor, commit, and CI time. Precise rules look like the code you’re searching; no more traversing abstract syntax trees, wrestling with regexes, or using a painful DSL. Code analysis is performed locally (code is not uploaded) and Semgrep runs on uncompiled code.

### Local Testing

It is important for the developers to have a fast and convenient way to run tools like this on a local machine.
The easiest way to do this is to run the tool with docker

```
$ cd /path/to/code
$ docker run --rm -v "${PWD}:/src" returntocorp/semgrep --config=p/security-audit --error
```

Otherwise you can install semgrep with the python packet manager.
```sh
# For Ubuntu/WSL/Linux/macOS
$ python3 -m pip install semgrep
```
From there you can simple run semgrep from the command line
```
semgrep --help
```

## CI/CD Integration

### Azure Pipelines
Below are the steps for integration with a yaml based pipeline:

```yaml
trigger:
- main

pool:
  vmImage: ubuntu-latest

steps:
- script: |
    docker run -v "$(Build.SourcesDirectory):/src" returntocorp/semgrep --config=p/r2c-security-audit --error
  displayName: "Perform SAST Security Audit"
  continueOnError: "false"
```

## Handeling False Positives
There will be a lot of false positives using SAST tools. Check all findings carefully. If you validated a finding a false positive you can suppress it from python source files by adding the comment `// nosemgrep` to the line that trigger the findings.

Example:

```typescript
bad_func(); // nosemgrep
bad_func(); // nosemgrep: rule-id-1
bad_func(); // nosemgrep: rule-id-1, rule-id-2
```
