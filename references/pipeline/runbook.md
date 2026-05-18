# Runbook: Client Context → Client Plugin

## Prerequisites

- **plugin-factory** installed (Cursor, Claude `--plugin-dir`, or Codex marketplace).
- A **client workspace** open (where `clients/` will be created).

## Fast path (~1 h to MVP plugin)

| Step | Time | Action |
| ---- | ---- | ------ |
| Parse client context | 15–30 min | `super-parse-discovery` |
| Gate A | 5 min | Review skill-map → `OK skill-map` |
| Bootstrap | 1 min | `new-client-plugin.sh --approve-gate-a` |
| Skill 1 + Gate B | 15–25 min | `super-build-client-plugin` (pilot only) |
| Skill 2 + Gate B | 15 min | `validating-claims` |
| **MVP usable** | **~1 h** | `validate-client-plugin.sh` + install |
| Rest of phase 1 | +1–2 h | optional same day |
| Phase 2 skills | later | when data/RAG ready |

Target MVP: **pilot skill + validating-claims** with `build.mode: phase_1` or `mvp`.

## One-command bootstrap (after Gate A)

From client workspace root:

```bash
"${CLAUDE_PLUGIN_ROOT}"/scripts/new-client-plugin.sh \
  --client-slug <slug> \
  --plugin-name <plugin-name> \
  --approve-gate-a
```

Creates plugin shell if missing, approves skill-map, prints next Codex prompt.

## Step by step

### 1. Save raw notes

```bash
mkdir -p clients/<slug>/discovery/raw
# Paste into clients/<slug>/discovery/raw/notes.md
```

### 2. Parse client context

```text
/plugin-factory:super-parse-discovery

Client slug: <slug>
Plugin name: <plugin-name>
Client info: @clients/<slug>/discovery/raw/notes.md  (or paste any client information directly)

Produce intake.md, process-map.md, skill-map.yaml (max 10 skills).
Set build.mode: phase_1. Map to catalog/base/. Include validating-claims if customer-facing output.
```

### 3. Gate A

Review `clients/<slug>/discovery/skill-map.yaml`:

- Right workflows and priorities?
- Exactly one `pilot_candidate: true`?
- `build.mode` correct (`phase_1` for fast path)?
- Phase 2 for RAG-heavy items?

Reply **OK skill-map** or run `new-client-plugin.sh ... --approve-gate-a`.

### 4. Build (agent auto-scaffolds)

```text
/plugin-factory:super-build-client-plugin

Client slug: <slug>
Plugin name: <plugin-name>
skill-map approved. Respect build.mode. Scaffold if missing.
Generate ONLY the next pending in-scope skill. STOP for SKILL.md approval.
```

After **OK skill &lt;name&gt;**, repeat for next skill or **OK skills 2-3** for batch (low-risk base only, max 3).

### 5. Validate and install

```bash
"${CLAUDE_PLUGIN_ROOT}"/scripts/validate-client-plugin.sh \
  --client-slug <slug> --plugin-name <plugin-name>

claude --plugin-dir ./clients/<slug>/<plugin-name>
```

## Time budget (full map)

| Step | Time |
| ---- | ---- |
| Parse discovery | 15–30 min |
| Gate A | 5–10 min |
| Scaffold | 1 min (automatic in build) |
| Per skill (draft + Gate B) | 15–25 min |
| 8 skills | ~2–3 h |
| Handover | 30 min |

Do not promise 10 perfect skills in 30 minutes.
