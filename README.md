# claude-toolkit

One shelf for the skill repos used across Victor's builds (P&L Home Group,
Cakes by Steph, Contractor OS). Clone this one repo, run one script, and the
right skills land in `/home/claude`.

## Why this exists

Each session starts with an empty workspace. The skill repos live at other
people's GitHub addresses, so they have to be fetched before they can be used.
This repo holds the fetch script and the task map, so that is two commands
instead of twelve.

## Setup (run at the start of a session)

```bash
git clone https://github.com/vpastor01/claude-toolkit.git
bash claude-toolkit/bootstrap.sh web      # or: seo | writing | video | app | context | convert | all
```

That pulls each upstream repo fresh into `/home/claude`.

See `MANIFEST.md` for the full profile-to-repo map.
