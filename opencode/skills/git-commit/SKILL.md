---
name: git-commit
description: Use when the user asks to commit, stage, or make a git commit. Covers staging files, writing commit messages with conventional commits, and making reversible atomic changes.
---

# Git Commit

## What I Do

Guides the agent through staging and committing changes with git. Enforces atomic commits, conventional commit messages, and reversible steps so every commit can be safely undone if needed.

## When to Use Me

- The user says "commit", "stage", "git commit", "make a commit", or "commit changes"
- The user asks to "add files" or "stage files" for commit
- The user mentions "revert", "undo", or "reversible" in context of git
- Any message about writing a commit message or following commit conventions

Use ONLY for git commit and staging operations. Do not activate for general git operations like push, pull, branch, or rebase unless they are part of a commit workflow.

## Workflow

### 1. Check Status First

Always start by checking what has changed:

```
git status
```

Review modified, added, and deleted files before staging anything.

### 2. Stage Changes Reversibly

Prefer staging files individually or by logical group rather than using `git add .`:

```
git add <file1> <file2>
```

Use `git add -p` for partial staging when a file contains unrelated changes.

### 3. Write a Conventional Commit Message

Use the Conventional Commits format:

```
<type>(<scope>): <short summary>

<body (optional)>
```

Types:
- `feat` — new feature
- `fix` — bug fix
- `refactor` — code change that neither fixes nor adds
- `docs` — documentation only
- `style` — formatting, missing semicolons, etc.
- `test` — adding or fixing tests
- `chore` — maintenance, tooling, dependencies

Scope is optional and should be the module or component name.

The summary is imperative, present tense, lowercase, no period:
- Good: `feat(auth): add login endpoint`
- Bad: `feat(auth): added login endpoint.`

The body is **required** — it must explain the reason for the change (the why, not the what). Wrap at 72 characters. Do not accept a commit without a body unless the change is trivially obvious.

Write all commit messages in English — both summary and body.

### 4. Commit

```
git commit -m "<message>"
```

Or for multi-line messages:

```
git commit -m "<type>(<scope>): <summary>" -m "<body>"
```

### 5. Verify

Run `git log --oneline -3` to confirm the commit looks correct.

## Reversibility

Every commit should be atomic — one logical change per commit — so it can be individually reverted:

```
git revert <commit-hash>
```

Before committing, confirm with the user if:
- There are untracked files that should be ignored
- A large number of files are being staged at once
- The commit message captures the intent correctly
