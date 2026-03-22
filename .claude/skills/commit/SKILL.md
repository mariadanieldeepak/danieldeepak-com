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

### 5. Auto-Generate Conventional Commit Message

Analyze the modified files to automatically determine commit type and generate message:

**Type Detection Logic:**
- **docs**: Only `.md`, `.mdx` files changed
- **style**: Only CSS, Tailwind, formatting files (`.css`, `.scss`, Prettier config)
- **test**: Only test files changed (`*.test.ts`, `*.spec.ts`)
- **refactor**: Code structure changes without feature/fix (TypeScript/JS changes with no new behavior)
- **feat**: New components, pages, or features (`.astro`, `.tsx`, `.ts` additions)
- **fix**: Bug fixes or corrections (existing file modifications)
- **build**: Build config or dependencies (package.json, astro.config, tsconfig)
- **ci**: CI/CD changes (GitHub Actions, workflow files)
- **chore**: Miscellaneous maintenance

**Scope Detection:**
- Extract directory/component name from modified files
- Examples: `Hero`, `BlogCard`, `config`, `image-optimization`

**Summary Generation:**
- Analyze the actual changes (git diff)
- Generate a concise, present-tense description
- Keep under 72 characters

**Message Format:** `<type>(<scope>): <summary>`

**Example:** `feat(Hero): add animated background gradient`

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
# Analyzes modified files and auto-generates a feature branch commit

/commit hotfix
# Creates a hotfix branch from master and auto-generates commit message for critical fixes
```

### What It Does

1. Shows git status and modified files
2. Detects commit type from file changes (feat, fix, docs, etc.)
3. Extracts scope from directory/component names
4. Generates commit message automatically
5. Creates feature/hotfix branch if needed
6. Commits with generated message

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
