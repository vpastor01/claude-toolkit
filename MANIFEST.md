# Skill manifest

The task-type map. Pick a profile, run `bash bootstrap.sh <profile>`, and the
matching repos clone into `/home/claude`.

| Profile | Repos pulled | Use it for |
|---------|--------------|------------|
| `web` | marketingskills, stop-slop, ui-ux-pro-max-skill, impeccable, anthropic-skills (frontend-design), playwright-skill | Building or editing a client site |
| `seo` | everything in `web` plus claude-seo, claude-blog, superseo-skills, web-quality-skills | Content, indexing, on-page SEO |
| `writing` | stop-slop | Any prose, fast |
| `video` | remotion-skills (from remotion-dev/skills) | Programmatic video |
| `app` | superpowers, Product-Manager-Skills, prompt-master, ralph, anthropic-skills (frontend-design), playwright-skill | Dashboard or product builds (Contractor OS) |
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
- `nidhinjs/prompt-master` - writes tight, tool-specific prompts for handing off to other AI tools (Cursor, Claude Code, v0, Midjourney). Reference on demand only; read its SKILL.md when actually generating a prompt, not every session. For lowest token cost, prefer the native Claude Skill install over reading it from here.
- `muratcankoylan/Agent-Skills-for-Context-Engineering` - clones to `context-engineering`
- `microsoft/markitdown` - file conversion; `pip install markitdown --break-system-packages`, then `markitdown input.pdf > output.md`
- `anthropics/skills` - clones to `anthropic-skills`; Anthropic's official skill library. The one to read is `skills/frontend-design/SKILL.md` (distinctive, production-grade UI, avoids AI-slop aesthetics). Overlaps with ui-ux-pro-max-skill and impeccable; pick per task.
- `lackeyjb/playwright-skill` - browser automation and E2E testing. Claude writes and runs Playwright on the fly (screenshots, console, multi-step flows). Mainly a Claude Code tool; needs Playwright browsers installed (`npm run setup` in the skill dir). Use to QA a client site or the Contractor OS dashboard.
- `snarktank/ralph` - the Ralph (Wiggum) autonomous-loop harness. Runs Claude Code repeatedly until every PRD item is done, fresh context each iteration, state in git + progress.txt + prd.json. A Claude Code harness, run on your machine, not inside a chat sandbox. Strong fit for long Contractor OS builds.

## MCP / external tools (not cloned by bootstrap)

- **Context7** (`upstash/context7`) - pulls up-to-date, version-specific library docs straight into the model's context, so generated code uses real current APIs instead of guesses. It is an MCP server (or a CLI+Skills setup), not a clone-style skill, so the bootstrap does not pull it. Install per agent:
  - Claude Code (MCP): `claude mcp add context7 -- npx -y @upstash/context7-mcp@latest`
  - Or CLI + Skills (no MCP): `npx ctx7 setup --claude` (OAuth, generates an API key, installs the skill)
  - Remote URL: `https://mcp.context7.com/mcp`, API key via the `CONTEXT7_API_KEY` header. Free key at context7.com/dashboard for higher limits.
  - Usage: add `use context7` to a prompt, or name a library directly, e.g. `use library /vercel/next.js`.
  - Note: it reaches context7.com / npx at runtime, which works in your local Claude Code but is blocked by the sandbox egress proxy here.

- **Crawl4AI** (`unclecode/crawl4ai`, Apache-2.0) - THE OS crawler of record. Open source, self-hosted, no API keys, no per-page fee. Used for client-site ingestion on onboarding, competitor/local recon, and ongoing monitoring. Ships an MCP server, a REST API, and a Python SDK.
  - Self-host (Docker): `docker run -d -p 11235:11235 --name crawl4ai --shm-size=3g unclecode/crawl4ai:latest`
  - Claude Code (MCP): `claude mcp add --transport sse c4ai-sse http://localhost:11235/mcp/sse`
  - Python in the backend: `pip install -U crawl4ai && crawl4ai-setup`. Returns `{url, html, markdown, extracted_content, metadata}`.
  - Test playground: `http://localhost:11235/playground`.
  - In the OS: put it behind one internal crawl interface so the provider can be swapped without touching callers.
  - Note: it hits arbitrary sites and `localhost:11235`, so it runs in your local Claude Code or the deployed backend, not in this chat sandbox (egress is locked here).

- **Firecrawl** (`firecrawl/firecrawl`, AGPL/hosted) - the FALLBACK and zero-infra quick-start. Use before the Crawl4AI container is up, or for sites with heavy JS / anti-bot that Crawl4AI doesn't beat out of the box (Firecrawl handles JS rendering, anti-bot, and proxy rotation). Hosted free tier ~1,000 pages/month, one credit per page.
  - Claude Code plugin (simplest): run `/plugin`, search `firecrawl`, install. Requires the Firecrawl CLI + an API key.
  - MCP: official server at `firecrawl/firecrawl-mcp-server`; needs `FIRECRAWL_API_KEY`.
  - Self-host is possible (AGPL) but only worth it if you specifically need Firecrawl's rendering at scale; otherwise default to Crawl4AI.


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
