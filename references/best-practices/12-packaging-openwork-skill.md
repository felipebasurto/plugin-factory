# 12. Packaging As An OpenWork Skill

OpenWork uses the same `SKILL.md` shape as Claude and Codex, but its distribution model is different. OpenWork does not have a manifest-based plugin format like Claude Code or Cursor. Skills are workspace-local files installed through the desktop app, share links, or OpenWork Cloud.

This file is the standard for shipping skills to OpenWork users.

## When To Use OpenWork

Use OpenWork as a target when:

- The client needs a private workspace with users, permissions, and history.
- The client benefits from a productized UI for skill execution.
- You already plan to deliver the workspace as the customer-facing surface.

If the client uses only Claude Code or Cursor, ship there instead. OpenWork is a delivery vehicle, not the default.

## Skill File Format

OpenWork skills follow the open Agent Skills format:

```markdown
---
name: skill-name
description: One-line description of what the skill does and when to use it.
---

Any markdown text with instructions and references for the skill.
```

Frontmatter rules:

- `name`: lowercase kebab-case.
- `description`: third person, with what and when. Same standard as `03-descriptions-and-triggers.md`.

The body follows the same authoring rules from `01`-`08`. A `SKILL.md` written for Claude Code or Codex is usable in OpenWork without changes.

## Workspace Layout

Workspace-local skills live under:

```text
.opencode/skills/skill-name/SKILL.md
```

For technical users, dropping a skill directly into `.opencode/skills/` makes it available inside that workspace.

Each workspace has its own skills. To share a skill across workspaces, use OpenWork Cloud or a share link.

## Install Paths

OpenWork supports four primary install flows:

1. Open an existing skill share link from `share.openworklabs.com`.
2. Paste a skill into the share site, then import it into a workspace.
3. Create a skill in chat using `/skill-creator` and paste the external skill into the flow.
4. Install from OpenWork Cloud via `Skills -> Cloud` or `Settings -> Cloud`.

For team distribution, OpenWork Cloud organizations can publish shared skills as standalone org skills or inside a skill hub.

## Cloud Distribution

When a teammate saves a skill to your active OpenWork Cloud organization, the desktop app surfaces it under `Skills -> Cloud` (or `Settings -> Cloud`). From there you can:

- `Install`: add the skill to the current workspace.
- `Sync`: pull the latest version from the cloud.
- `Uninstall`: remove the workspace-managed copy.

Skills owned by a hub also display the hub name so users know the source.

## Share Links

Share links are the simplest way to ship a single skill to external users:

1. Open `share.openworklabs.com` without any skill loaded.
2. Paste or upload the `SKILL.md`.
3. Click `Generate link`.
4. Send the link to the user.
5. The user clicks `Open in OpenWork`, picks a workspace, and reloads.

The shared file must follow the standard frontmatter or the share site rejects it.

## Authoring For OpenWork

OpenWork skills are markdown-only at the import layer. The recommended discipline:

- Keep the `SKILL.md` self-contained for share-link distribution. References inside the skill folder are supported when the skill is installed manually under `.opencode/skills/skill-name/`.
- For cloud-distributed skills, prefer self-contained `SKILL.md` files. If you need supporting files, document the layout in the body so users know what to copy.
- Use the same workflow, output, and refusal sections as on other platforms.
- Avoid platform-specific assumptions in the body. A skill that works on Claude and Codex usually works in OpenWork.

## DMKINGS Conventions

For OpenWork deliverables, DMKINGS should:

- Maintain a canonical `SKILL.md` per skill in the plugin repo.
- Mirror that file into the OpenWork Cloud organization or share link when shipping.
- Treat OpenWork Cloud as the source of truth for the installed copy; treat the repo as the source of truth for the authored copy.
- Bump the skill version inline in the body (for example, a `## Version` line near the bottom) since OpenWork has no manifest version field.
- Document install steps in the client handover guide.

## Reload And Iteration

After installing or updating a skill, OpenWork prompts to reload the app so the workspace picks it up. When iterating locally, edit `.opencode/skills/skill-name/SKILL.md` and reload the workspace.

## Validation Before Shipping

- The `SKILL.md` passes the standard review checklist in `08-review-checklist.md`.
- The skill imports cleanly via share link.
- The skill installs cleanly from OpenWork Cloud if cloud-distributed.
- The skill runs end to end in the target workspace.
- The handover guide names the exact install path (`Skills -> Cloud`, share link, or `/skill-creator`).

## Anti-Patterns Specific To OpenWork

- Shipping multi-file skills via share link. Share links only carry the `SKILL.md` body. Use cloud install or manual placement under `.opencode/skills/`.
- Embedding client-specific knowledge in a skill published to the public share site. Use private cloud organizations for client packs.
- Treating OpenWork as if it had a Claude or Cursor manifest. There is no `.openwork-plugin/plugin.json`. The unit of distribution is the `SKILL.md`.
- Skipping the version note in the body. Without a manifest version, users cannot tell which copy they have.
- Forcing OpenWork on clients who already run a working Claude or Cursor stack.
