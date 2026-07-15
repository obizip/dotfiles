---
name: skill-creator
description: Use when creating, editing, or understanding opencode skills. Covers the SKILL.md format, frontmatter requirements, default directory locations, body structure conventions, and best practices for naming and description.
---

# Skill Creator

## What I Do

Guides the agent through creating, editing, and validating opencode skills. Covers the SKILL.md format, frontmatter schema, body structure conventions, directory placement, and registration options so every skill is well-formed and discoverable.

## When to Use Me

- The user says "create a skill", "new skill", "write a skill", or "make a skill"
- The user asks about skill format, structure, or best practices
- Editing any `SKILL.md` file or files inside a `.opencode/skills/` directory
- The user mentions skill frontmatter fields like `name`, `description`, `license`, or `compatibility`
- Any question about where skills live, how they're loaded, or how to register them

Use ONLY when the topic is opencode skills themselves. Do not activate for general opencode configuration (agents, commands, plugins, MCP servers) or for application-level coding tasks.

## Directory Layout

Place every skill in a default location. Do not use custom `skills.paths` registration.

Project:

```
.opencode/skills/<skill-name>/SKILL.md
```

Global:

```
~/.config/opencode/skills/<skill-name>/SKILL.md
```

External (auto-scanned, no config needed):

```
~/.claude/skills/<skill-name>/SKILL.md
~/.agents/skills/<skill-name>/SKILL.md
```

opencode scans for `**/SKILL.md` recursively inside these directories. The file **must** be named `SKILL.md` exactly.

## Frontmatter

```markdown
---
name: my-skill
description: One sentence covering what this skill does AND when to trigger it.
---

# My Skill

## What I Do

(concise description of the skill's purpose and what it helps the user accomplish)

## When to Use Me

(clear trigger conditions: keywords the user might say, file patterns, project contexts, or commands that should activate this skill. Use "Use ONLY when..." to gate narrow skills.)
```

Required fields:

- **`name`** — lowercase, hyphen-separated, up to 64 chars, must match the folder name.
- **`description`** — write in third person ("Use when...", not "I help with..."). Front-load concrete trigger keywords and filenames. Cover both *what* the skill does and *when* to use it. Use "Use ONLY when..." if the skill should stay quiet on adjacent topics.

## Body Structure

Every skill body should start with these two sections:

### What I Do

A short paragraph stating the skill's singular purpose. Answer: what will the agent be able to do after loading this skill? Be concrete.

Example:
```markdown
## What I Do

Guides the agent through writing unit tests for Python projects using pytest. Includes project structure conventions, fixture patterns, and assertion style.
```

### When to Use Me

List the exact triggers that should cause the model to load this skill. Front-load the most specific keywords. Use bullet points for clarity. If the skill is narrowly scoped, begin with "Use ONLY when...".

Example:
```markdown
## When to Use Me

- The user says "write tests", "add unit tests", or "test this module"
- Files named `test_*.py` or `*_test.py` are being edited
- The project contains a `pytest.ini`, `pyproject.toml` with pytest config, or a `tests/` directory
- Any message mentioning "pytest", "unittest", or "coverage"

Use ONLY when the task involves Python testing. Do not activate for general Python coding or other language testing.
```

### Asking Questions

If the user's request is ambiguous or lacks detail needed to create the skill properly (e.g., unclear purpose, missing trigger keywords, unsure about placement), use the `question` tool to ask the user for clarification before proceeding. Do not guess.

Examples of when to ask:
- The user says "create a skill" but doesn't specify what it should do
- The purpose is vague and you need concrete trigger keywords
- You're unsure whether it belongs in project or global scope

### After These Two Sections

Add any additional sections the skill needs — examples, configuration reference, workflow steps, guardrails, etc. Keep the body focused on one concern.

## Registration

Skills are auto-discovered from default locations. Do not configure `skills.paths` or `skills.urls` in `opencode.json` — use the standard paths below so skills work without extra config.

Default locations (scanned automatically):

| Scope | Path |
|-------|------|
| Project | `.opencode/skills/<name>/SKILL.md` |
| Global | `~/.config/opencode/skills/<name>/SKILL.md` |
| External | `~/.claude/skills/<name>/SKILL.md` |
| External | `~/.agents/skills/<name>/SKILL.md` |

Place every skill in one of these directories. Custom registration via `skills.paths` or `skills.urls` is rarely needed and makes skills harder to discover.

## Best Practices

1. **Name** — short, descriptive, lowercase-hyphenated. Match the folder name exactly.
2. **Description** — front-load keywords the user is likely to say or type. Include filenames if relevant. Gate narrow applicability with "Use ONLY when...".
3. **Body** — always start with `## What I Do` and `## When to Use Me`. Then add instructions, examples, references, and guardrails. Be prescriptive.
4. **What I Do** — one paragraph, singular focus. Never list multiple unrelated purposes in one skill.
5. **When to Use Me** — be specific about trigger keywords, file patterns, and project context. Use "Use ONLY when..." for narrow skills so they don't fire on adjacent topics.
6. **References** — if the skill needs external context (docs, SDKs), use the `references` field in `opencode.json` rather than embedding large content.
7. **Existing skills** — before creating a new skill, check existing skills to avoid duplication. Skills without a `description` are filtered out and never surfaced.
8. **Language** — write all skill content in English, including frontmatter `name`, `description`, and the body. English is the lingua franca of opencode's agent system and ensures consistent matching and loading.
9. **One Responsibility** — keep skills focused on one concern. A skill that tries to do too much will trigger incorrectly.
