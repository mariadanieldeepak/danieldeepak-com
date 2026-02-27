---
name: commit
description: Check git changes and commit with Conventional Commits following git-flow standards
disable-model-invocation: true
allowed-tools: Bash, Read
---

# Commit Workflow

Perform an interactive commit following git-flow branching and Conventional Commits standards.

## Parameters

- `hotfix` (optional): When specified, create a hotfix branch from master instead of a feature branch

## Workflow

### 1. Show Repository Status

Run:
```bash
git status -sb
git diff --stat
```

Display which files have been modified.

### 2. Verify Changes Exist

If no changes exist, report and stop.

### 3. Determine Current Branch

Run:
```bash
git branch --show-current
```

Analyze what type of branch logic to apply.

### 4. Create/Navigate to Appropriate Branch

**If on `develop` and hotfix NOT specified:**
- Create feature branch: `feature/<slug>`
- Slug should be kebab-case derived from the commit summary
- Branch from: develop

**If on `master` and hotfix IS specified:**
- Create hotfix branch: `hotfix/<slug>`
- Slug should be kebab-case derived from the commit summary
- Branch from: master

**If on `master` and hotfix NOT specified:**
- Report error: "Commits must be on feature/release/hotfix branch, not directly on master"
- Stop

**If already on feature/hotfix/release branch:**
- Proceed without creating a new branch

### 5. Create Conventional Commit Message

Prompt the user for:
- **Type**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, or `revert`
- **Scope**: (optional) component or module name
- **Breaking change**: (y/n) - adds `!` after type if yes
- **Summary**: concise description

Message format: `<type>(<scope>)<!>: <summary>`

Validate against regex:
```
^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\([^)]+\))?(!)?: .+
```

### 6. Stage and Commit

Run:
```bash
git add -A
git commit -m "<message>"
```

Display success message with branch and commit info.

## Example Usage

```
/commit
# Interactive prompts guide through creating a feature branch commit

/commit hotfix
# Creates a hotfix branch from master for critical fixes
```

## Conventional Commits Reference

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, semicolons, etc.)
- **refactor**: Code refactoring without feature or bug changes
- **test**: Adding or updating tests
- **chore**: Maintenance tasks (build, dependencies, etc.)
- **perf**: Performance improvements
- **ci**: CI/CD changes
- **build**: Build system changes

## Breaking Changes

Prefix type with `!` for breaking changes:
```
feat!: remove deprecated API
fix(auth)!: change token format
```

## Related

See `.claude/rules/git-workflow-standards.md` for complete git-flow and conventional commits standards.
