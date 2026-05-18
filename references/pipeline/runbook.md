# Runbook: Discovery Day → Client Plugin

## Prerequisites

- **plugin-factory** installed (Cursor: `~/.cursor/plugins/local/plugin-factory` or Claude `--plugin-dir`).
- A **client workspace** repo open (where `clients/` will be created).

## Before the meeting

- Plan to paste notes into `clients/<slug>/discovery/raw/notes.md` in the client workspace.

## After discovery (same day or next morning)

### 1. Save raw notes

In the **client workspace**:

```bash
mkdir -p clients/<slug>/discovery/raw
# Paste into clients/<slug>/discovery/raw/notes.md
```

### 2. Parse discovery

In Cursor or Claude Code:

```text
/plugin-factory:super-parse-discovery

Client slug: <slug>
Plugin name: <plugin-name>
Discovery: @clients/<slug>/discovery/raw/notes.md

Produce intake.md, process-map.md, and skill-map.yaml (max 10 skills).
Map to references/catalog/base/ first. Include validating-claims if any customer-facing output.
```

### 3. Gate A — approve skill map

Review `clients/<slug>/discovery/skill-map.yaml`:

- Are these the right 6-10 workflows?
- Is exactly one `pilot_candidate: true`?
- Any skill marked `phase: 2` for RAG/MCP?

Reply: **"OK skill-map"** and set `approved: true` in the file (or ask the agent to set it).

### 4. Scaffold plugin shell

From the **client workspace root**:

```bash
~/.cursor/plugins/local/plugin-factory/scripts/scaffold-client-plugin.sh \
  --client-slug <slug> \
  --plugin-name <plugin-name>
```

Or use the Cursor command **scaffold-client-plugin** from plugin-factory.

### 5. Build skills one by one (Gate B)

```text
/plugin-factory:super-build-client-plugin

Client slug: <slug>
Plugin name: <plugin-name>
skill-map is approved.

Generate ONLY skill id 1 from the map. Stop for my approval on SKILL.md.
```

After each **"OK skill N"**, ask for skill N+1.

### 6. Install and smoke test

```bash
claude --plugin-dir ./clients/<slug>/<plugin-name>
```

```text
/reload-plugins
/<plugin-name>:<first-skill>
```

### 7. Handover

Use your org's delivery checklist for claims review and client sign-off.

## Time budget (realistic)

| Step | Time |
| ---- | ---- |
| Parse discovery | 15-30 min |
| Gate A review | 10 min |
| Scaffold | 2 min |
| Per skill (draft + Gate B) | 15-25 min each |
| 8 skills | ~2-3 hours agent-assisted |
| README + handover | 30 min |

Do not promise 10 perfect skills in 30 minutes total.
