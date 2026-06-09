# Skill manifest

The task-type map. Pick a profile, run `bash bootstrap.sh <profile>`, and the
matching repos clone into `/home/claude`.

| Profile | Repos pulled | Use it for |
|---------|--------------|------------|
| `web` | marketingskills, stop-slop, ui-ux-pro-max-skill, impeccable | Building or editing a client site |
| `seo` | everything in `web` plus claude-seo, claude-blog, superseo-skills, web-quality-skills | Content, indexing, on-page SEO |
| `writing` | stop-slop | Any prose, fast |
| `video` | remotion-skills (from remotion-dev/skills) | Programmatic video |
| `app` | superpowers, Product-Manager-Skills | Dashboard or product builds (Contractor OS) |
| `context` | context-engineering | Long, complex sessions |
| `convert` | markitdown | PDF/DOCX/PPTX/XLSX/image to Markdown |
| `all` | every repo above | Full toolkit |

## Repo reference

- `coreyhaines31/marketingskills` - CRO, SEO, copywriting, marketing
- `hardikpandya/stop-slop` - writing standard: no adverbs, no passive voice, no filler, no em dashes, no pull-quotes, no binary contrasts, vary rhythm, be specific
- `nextlevelbuilder/ui-ux-pro-max-skill` - UI/UX; search script at `src/ui-ux-pro-max/scripts/search.py`
- `pbakaus/impeccable` - 23 polish commands; run before shipping any page or component
- `AgriciDaniel/claude-seo` - technical and on-page SEO
- `AgriciDaniel/claude-blog` - blog content
- `inhouseseo/superseo-skills` - SEO toolkit
- `addyosmani/web-quality-skills` - web quality and performance
- `remotion-dev/skills` - clones to `remotion-skills`; reference `skills/remotion/SKILL.md`; uses `useCurrentFrame()` and `interpolate()`, no CSS transitions
- `obra/superpowers` - app and product build skills
- `deanpeters/Product-Manager-Skills` - product management
- `muratcankoylan/Agent-Skills-for-Context-Engineering` - clones to `context-engineering`
- `microsoft/markitdown` - file conversion; `pip install markitdown --break-system-packages`, then `markitdown input.pdf > output.md`

## Personal context (private)

Every run also tries to load my personal context files from the private repo
`vpastor01/claude-context`:

- `about-me.md` — who I am, how I work, what I hate
- `my-company.md` — both businesses, strategy, focus
- `anti-ai-writing-style.md` — my writing standard, long form

These hold business strategy, so they live in a **private** repo and are never
copied into this public one. The clone needs auth: `export GH_TOKEN=<token>`
before running bootstrap, or clone the repo directly. Without a token the
bootstrap skips them and prints a note.

## Notes

- These repos are third-party. This toolkit clones them fresh from each owner so
  attribution and licensing stay with the source. Nothing is copied or
  re-hosted here.
- Repomix (v1.14.1) is the standard for packing a codebase into one XML context
  file before a large session: `repomix --remote vpastor01/<repo> --style xml -o repo.xml`
