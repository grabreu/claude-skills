# claude-skills

Personal [Claude Code](https://claude.com/claude-code) skills, each with its own templates and scripts.

## Skills

| Skill | What it does |
|---|---|
| [new-repo](skills/new-repo/SKILL.md) | Creates a GitHub repo with the standard baseline (templates, dependabot, ruleset, Actions pinning, security settings) or audits an existing one. |

## Install

Link a skill into Claude Code's skills directory. On Windows (PowerShell):

```powershell
New-Item -ItemType Junction -Path "$HOME\.claude\skills\new-repo" -Target "<path-to-clone>\skills\new-repo"
```

On macOS or Linux:

```bash
ln -s <path-to-clone>/skills/new-repo ~/.claude/skills/new-repo
```

## License

Licensed under the [MIT License](LICENSE).
