## Rules
- Good title that includes the type of PR as below
- Good description - not default one
- Good commit messages to understand what you did for each
- Comments for complex parts of code that you want checked and tag a senior
- Ticket connection in PR
- Draft PR for unfinished work at the end of the day (pls include comments and tags so that seniors can have more time to check before final PR)



## Branching (git-flow and draft pr first):
### Naming conventions
- Build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- CI: Changes to our CI configuration files and scripts (example scopes: Circle, BrowserStack, SauceLabs)
- Docs: Documentation only changes
- Feat: A new feature
- Fix: A bug fix
- Perf: A code change that improves performance
- Refactor: A code change that neither fixes a bug nor adds a feature
- Test: Adding missing tests or correcting existing tests
- Chore, updating azure pipeline, etc.; no production code change

[Github Contributing to Angular](https://github.com/angular/angular/blob/master/CONTRIBUTING.md)


### Examples
- feat/<story-number>_<meaningful name>
- fix/1234_vat_does_not_show_up
- chore/2345_azure_pipeline_refactoring
- For commits: feat: [work item id] - A new feature fix: [work item id] - A bug fix chore: [work item id] - A maintenance / set up / refactoring

