# Adding Static Application Security Testing (SAST) to Python Projects

## Bandit
Bandit is a tool designed to find common security issues in Python code.

### Local Testing
It is important for the developers to have a fast and convenient way to run tools like this on a local machine.
The easiest way to do this is to run the tool with docker

```
docker pull opensorcery/bandit
docker run --rm -v ${PWD}:/code opensorcery/bandit -r path/to/your/code
```

Otherwise you can install bandit with the python packet manager.

```
pip install bandit
# Or if you're working with a Python 3 project
pip3 install bandit
```

From there you can simple run bandit from the command line

```
bandit -r path/to/your/code
```

If you want to exclude a specific directory from the scan you use the following command:

```
bandit -r path/to/your/code -x path/to/your/code/tests 
```

## CI/CD Integration
The local testing should only be used for debugging or before pushing a new code to the repository. There is a huge benefit to integrate SAST tools to your CI/CD pipeline to check every pull request for new vulnerabilities. Here are some examples to integrate bandit to your build pipeline.

### GitHub Actions
Add the following to the file `.github/workflows/bandit.yml`.
```yaml
name: SAST (bandit)

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 2
      - run: git checkout HEAD^
      - name: Bandit Check
        uses: jpetrucciani/bandit-check@1.6.2
        with:
          path: '.'
```

### Docker Based
If you are using a docker based approach (like in Azure DevOps) you can run the following commands in you pipeline:

```
docker pull opensorcery/bandit
docker run --rm -v ${PWD}:/code opensorcery/bandit -r path/to/your/code
```
### Other Methods
To integrate bandit in other CI tools (like Jenkins) you also can install the tool via pip and run it from the command line.

## Handeling False Positives
There will be a lot of false positives using SAST tools. Check all findings carefully. If you validated a finding a false positive you can suppress it from python source files by adding the comment `# nosec` to the line that trigger the findings.

Example:

```
the_hash = md5(data).hexdigest()  # nosec
```
