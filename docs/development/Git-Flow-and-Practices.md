# Git Flow and Practices

## 1. Git Flow Model

<br/>

![image.png](./attachments/image-7260c5de-78f4-48d6-938f-9c2f9fbad286.png)

## 1.1. Terms

### 1.1.1. Primary Branch

Primary branches exist perpetually, and have continuous evolutions on them. Typical primary branches include

- develop
- main

### 1.1.2. Working Branch

Working branches is created temporarily, and has short-term existence. They can be deleted after the code being transferred to primary branches. Typical working branches include

- feature
- release
- hotfix

## 1.2. Rules

1. New code is always generated from working branches, merged to primary branches via pull request.
1. No direct merge between different primary branches. Code is transferred between primary branches via cherry pick with the help of working branches as a "springboard".
1. Feature branch is checked out from develop branch, merged back to develop branch via pull request.
1. Release branch is checked out from main branch, merged back to main branch via pull request.
1. Hotfix branch is checked out from main branch, merged back to hotfix branch via pull request.

## 1.3. Code Transferring

**Code generated on feature branch**

![image.png](./attachments/image-392336d6-a8b6-4367-8c67-39c5648014a3.png)

**Code generated on release branch**

![image.png](./attachments/image-438ea1e6-98ec-441f-9cca-0669a09b93d9.png)

**Code generated on hotfix branch**

![image.png](./attachments/image-db1e3440-7da4-4a05-870e-eeed3d906b8c.png)

## 1.4. Mappings between Environment and Branches

| Environments | Branches                                  |
| ------------ | ----------------------------------------- |
| development  | develop(automatically), feature(manually) |
| testing      | release(automatically), hotfix(manually)  |
| staging      | main(automatically)                       |
| production   | main(manually)                            |

## 2. Practices

## 2.1. Working Branch Name

```
# feature branch name
feature/#<number>-<subject>

# release branch name
release/#<number>-<subject>

# hotfix branch name
hotfix/#<number>-<subject>
```

- **<number>**, number of Azure DevOps Product Backlog Item or Bug
- **<subject>**, short description, use dash "-" to replace space

**Example**

_feature/<span>#182320</span>-remove-product-url-from-product-entity_
_release/<span>#177393</span>-release-0.5.0_
_hotfix/<span>#188879</span>-hotfix-0.5.1_

## 2.2. Commit Message

```
<type>(<scope>): <subject> (#<number>)
```

- **<type>**, required, kind of change that this commit is providing, allowed types include
  - **feat**, feature
  - **fix**, bug fix
  - **docs**, documentation
  - **style**, code formatting
  - **refact**, code refactoring
  - **test**, testing code
  - **chore**, maintain
- **<scope>**, optional, place of change of this commit
- **<subject>**, required, short description of this commit
- **<number>**, required, number of Azure DevOps Task

**Example**

_feat(db): add db migration script (<span>#182826<span>)_
_chore(release): update version number to 1.2.2 (<span>#179403</span>)_
_docs(): add product info in readme (<span>#160789</span>)_

## 2.3. Branch Policies

![CleanShot 2022-05-21 at 13.22.29@2x.png](./attachments/CleanShot%202022-05-21%20at%2013.22.29@2x-d893fbf4-18fb-4b28-b3a6-537f33bab61c.png)

### 2.3.1. Squash Merge

Squash merge can condense the commits on the source branch into a single new commit on the target branch. All commits on a feature branch are condensed into a single new commit on the develop branch. All commits on a release branch are condensed into a single new commit on the main branch.

## 2.4. Pull Request

### 2.4.1. Title

```
<type>(<scope>): <subject> (#<number>)
```

Azure DevOps uses the pull request title as the default value of the new commit message subject on the target branch. So it follows the same naming convention as commit message.

Since the target branch are always primary branches, the number in pull request title shall always belongs to an Azure DevOps work item of type - Product Backlog Item or Bug.

### 2.4.2. Description

```
- <type>(<scope>): <subject> (#<number>)
- <type>(<scope>): <subject> (#<number>)
...

<state>: #<number>, #<number>, ...

```

**Add commit messages**

Azure DevOps uses the pull request description as the default value of the new commit message body on the target branch. In _New pull request_, Azure DevOps provides an _Add commit messages_ function which fills in the description with all commit messages on the source branch automatically. Therefore, even with squash merge, all commit messages on the source branch can still be listed in the message body of the new single commit on the target branch.

### 2.4.3. Complete pull request

![CleanShot 2022-05-21 at 22.34.25@2x.png](./attachments/CleanShot%202022-05-21%20at%2022.34.25@2x-29d7c8ec-812f-42ad-91f8-f91684fe5a04.png)

As the snapshot shown above, follow the steps listed below to complete a pull request

1. Make sure the merge type is set to _Squash commit_
1. Make sure the _Customize merge commit message_ option is checked
1. Remove _Merged PR #####_ prefix from default commit message subject
1. Set work item state if needed

**Set work item state in pull request**

Azure DevOps provides the function to update work item state in pull request. For details, please refer [Microsoft Docs Set work item state in pull request](https://docs.microsoft.com/en-us/azure/devops/notifications/add-links-to-work-items?view=azure-devops#set-work-item-state-in-pull-request)


## 2.5. Work Item State Change

Here are the mappings between code transferring and state change for Azure DevOps work item of type - Product Backlog Item and Task.

### 2.5.1. Product Backlog Item

| State            | When                                        | How              | Who                         |
| ---------------- | ------------------------------------------- | ---------------- | --------------------------- |
| Ready            | definition is refined                       | manually         | tech lead                   |
| Committed        | is assigned                                 | manually         | owner developer             |
| In Progress      | development is started                      | manually         | owner developer             |
| Development Done | commits are merged to develop branch        | via pull request | other developer, tech lead  |
| Ready for Test   | commits are self-tested by developer        | manually         | owner developer             |
| In Test          | testing is started                          | manually         | testing engineer            |
| Done             | commits are tested by testing               | manually         | testing engineer, tech lead |

### 2.5.2. Task

| State        | When                      | How              | Who                         |
| ------------ | ------------------------- | ---------------- | --------------------------- |
| To Do        | -                         | manually         | owner                       |
| In Progress  | coding is started         | manually         | owner                       |
| Technical QA | pull request is created   | manually         | owner                       |
| Done         | pull request is completed | via pull request | other developers, tech lead |

## 3. Q&A

**Q1: Why not use the Trunk Based Development model, which is much simpler?**

TBD depends on a high automation test coverage and strong code review capability, which we don't have in this project yet.
The rapid release requirement to which TBD is more suitable doesn't exist in this project.
The Continuous Deployment in this project is too complicated to fit TBD.

**Q2: Why not check out release branch directly from development branch?**

Checking out release branch from develop branch and merging it to main branch always generates a full list of the commits since init checkout of develop branch.
![image.png](./attachments/image-05b9e561-7058-47f1-8627-8e98e9a02019.png)

Checking out release branch from main branch makes it easier for Azure DevOps to find out the incremental list of the commits since last release.
Checking out release branch from main branch also allows finished features on develop branch to be picked to and tested on release branch as early as possible.
![image.png](./attachments/image-954858db-0b1b-49a7-9908-6c78e087fc66.png)
