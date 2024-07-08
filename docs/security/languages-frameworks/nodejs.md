# Node.js good security practices

## Adding Static Application Security Testing (SAST) to Node.js Projects

### Linting

There is a big misunderstanding between static code analysis (like linting) and static application security testing (SAST). Both methods are static code analysis, but usually linters are used to find stylistic errors in the code while SAST tools are used to find specific security bugs.

The Node Security Platform also provides a plugin for the node linter to add some security checks. This might be a quick win if the linter is running in the CI/CD pipeline anyway.

Run the following command to install the security plugin

`npm install --save-dev eslint-plugin-security`

Add the following to your .eslintrc file:

```json
"plugins": [
  "security"
],
"extends": [
  "plugin:security/recommended"
]
```

This will add some security checks as a quick win to your linting process. There will be a lot of false positives which need triage by a human.

### njsscan

![nodejsscan](https://user-images.githubusercontent.com/4301109/83994121-74fe6500-a923-11ea-9ad7-012113f1bb12.png)
![nodejsscan2](https://user-images.githubusercontent.com/4301109/83980766-44e4a100-a8e6-11ea-9770-b179faf7f6ac.png)

A more effective way is to setup a real SAST tool. njsscan is a static application testing (SAST) tool that can find insecure code patterns in your nodejs applications.

#### Local Testing

It is important for the developers to have a fast and convenient way to run tools like this on a local machine.
The easiest way to do this is to run the tool with docker

```bash
docker pull opensecurity/njsscan
docker run -it -p 9090:9090 opensecurity/nodejsscan:latest
```

After the container is up and running, there is a web interface available on `http://localhost:9090`. You can easily clone a git repository or simply upload a zip file and run the analysis.

If you don’t want to use the web interface, you can run the cli version using the following command:

```bash
docker run -v /path-to-source-dir:/src opensecurity/njsscan /src
```

#### CI/CD Integration

The local testing should only be used for debugging or before pushing a new code to the repository. There is a huge benefit to integrate SAST tools to your CI/CD pipeline to check every pull request for new vulnerabilities. Here are some examples to integrate njsscan to your build pipeline.

#### GitHub Actions

Add the following to the file .github/workflows/njsscan.yml.

```yaml
name: njsscan
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
jobs:
  njsscan:
    runs-on: ubuntu-latest
    name: njsscan check
    steps:
    - uses: actions/checkout@v1
    - name: njsscan
      id: njsscan
      uses: ajinabraham/njsscan-action@v5
      with:
        args: ‘.'
```

#### Docker Based

If you are using a docker based approach (like in Azure DevOps) you can run the following commands in you pipeline:

```bash
docker pull opensecurity/njsscan
docker run -v /path-to-source-dir:/src opensecurity/njsscan /src
```

#### Other Methods

To integrate njsscan in other CI tools (like Jenkins) or if docker is not available you also can install the tool via pip and run it from the command line.

```bash
pip install njsscan
njsscan /path-to-source-dir
```

#### Handling False Positives

As mentioned before, there will be a lot of false positives. Check all findings carefully. If you validated a finding as false positive you can suppress it from javascript source files by adding the comment `//ignore: rule_id1, rule_id2` to the line that trigger the findings.

Example:

```nodejs
app.get('/some/redirect', function (req, res) {
    var target = req.param("target");
    res.redirect(target); //ignore: express_open_redirect
});
```

#### Useful parameters

The report file can be converted to JSON or a SonarQube compatible file format by adding either `—json` or `—sonarcube` (with two dashes!) to the command line parameters. 

## Further read

- [OWASP NodeJS security cheat sheet](https://cheatsheetseries.owasp.org/cheatsheets/Nodejs_Security_Cheat_Sheet.html)
- [23 nodejs best practices](https://medium.com/@nodepractices/were-under-attack-23-node-js-security-best-practices-e33c146cb87d)