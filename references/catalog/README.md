# Skill Catalog

## base/

Generic industrial B2B skills to **adapt** per client. Do not ship `catalog/base/` directly to clients.

When building a client plugin, `super-parse-discovery` maps discovery workflows to these names, then `super-build-client-plugin` adapts triggers and references.

## Notable base skills

| Skill | Use when |
| ----- | -------- |
| `documenting-design-system` | Brand PDF/PPT/screenshots → `shared/design-system.md` + client `applying-*-design-system` skill |

## Conventions

See [conventions.md](conventions.md).
