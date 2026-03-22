# Release

Run a git-flow style release for the version the user gives (for example `v0.1.0` or `0.1.0`). Follow [.claude/rules/git-workflow-standards.md](.claude/rules/git-workflow-standards.md): release branch `release/v<semver>`, `--no-ff` merges, annotated tag with `v` prefix on the production branch, then merge back to `develop` and delete the release branch.

## Steps

1. Require a clean working tree (no uncommitted changes) before starting.
2. From the repo root, run:

   ```bash
   ./scripts/release.sh <version>
   ```

   Examples: `./scripts/release.sh v0.1.0` or `./scripts/release.sh 0.1.0`.

3. The script will:
   - Set `package.json` `version` to the semver (no `v` prefix).
   - Create `release/v<semver>` from `develop` if it does not exist, or check it out and merge `develop` into it with `--no-ff` if it does.
   - Commit the version bump as `chore(release): bump version to <semver>` when `package.json` changes.
   - Merge the release branch into **production** with `--no-ff` (`master` if present, otherwise `main`).
   - Create an **annotated** tag `v<semver>` with message `Release version <semver>` on the production branch (after that merge).
   - Merge the release branch into `develop` with `--no-ff` and delete the local release branch.
4. **Do not** `git push` or open a PR unless the user explicitly approves. When done, tell them the release is local only and they can push with:

   ```bash
   git push origin <production-branch> develop --tags
   ```

   Use the actual production branch name (`main` or `master`).

If the script fails (merge conflict, dirty tree, tag already exists), stop and report; do not force-push or delete tags without explicit user direction.
