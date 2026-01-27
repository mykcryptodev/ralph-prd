# AGENTS.md - Ralph PRD Plugin Patterns

This document captures patterns and conventions for maintaining the Ralph PRD plugin.

## Project Structure

```
ralph-skill/
├── .claude-plugin/
│   └── plugin.json       # Plugin manifest (name, version, description)
├── skills/
│   └── prd/
│       └── SKILL.md      # The main skill definition file
├── scripts/
│   └── ralph.sh          # Bundled ralph.sh script for users to copy
├── .claude/
│   └── settings.local.json  # Local development settings (not part of plugin)
├── AGENTS.md             # This file - patterns for contributors
├── PRD.md                # Product requirements for THIS repo
├── progress.txt          # Progress log for THIS repo's development
└── README.md             # Installation/usage instructions for users
```

## Plugin Structure Conventions

### Location
- Plugin manifest lives in `.claude-plugin/plugin.json`
- Skills live in `skills/[skill-name]/SKILL.md` at plugin root (NOT inside `.claude-plugin/`)
- Scripts live in `scripts/` at plugin root
- Users install via `/plugin install github:username/ralph-prd`
- Plugin is installed to `~/.claude/plugins/ralph-prd/`

### Frontmatter Format
Skills use YAML frontmatter for metadata:

```yaml
---
name: skill-name
description: Description with trigger phrases like "create a prd" or "plan feature"
---
```

Key fields:
- `name`: The skill identifier (used in `/plugin-name:skill-name` command)
- `description`: Include trigger phrases that invoke the skill automatically

For this plugin, the command is `/ralph-prd:prd` (namespaced).

### Skill Body
The markdown body contains instructions for Claude to follow when the skill is invoked. Structure tips:
- Use numbered steps for sequential operations
- Include example outputs so Claude knows the expected format
- Specify file creation with exact content when needed

## ralph.sh Script

### Purpose
`ralph.sh` is the autonomous implementation loop that:
1. Invokes Claude Code with the Ralph agent prompt
2. Runs until PRD.md shows all tasks complete
3. Each iteration: reads PRD, implements one task, tests, commits if passing

### Key Parameters
- `MAX_ITERATIONS`: Prevents infinite loops (default: 50)
- `--allowedTools`: Restricts Claude to safe tools (Edit, Write, Bash, Read, etc.)
- `--continue`: Continues conversation instead of starting fresh each iteration

### Script Location
- Bundled with plugin at `scripts/ralph.sh`
- Users copy to their project: `cp ~/.claude/plugins/ralph-prd/scripts/ralph.sh ./`
- Needs executable permission (`chmod +x ralph.sh`)

## How Plugin Skills Are Loaded by Claude Code

1. Claude Code scans installed plugins in `~/.claude/plugins/`
2. Each plugin's `skills/` directory contains skill subdirectories
3. Skill files must be named `SKILL.md` (case-sensitive)
4. Skills are matched by:
   - Explicit namespaced command: `/plugin-name:skill-name` (e.g., `/ralph-prd:prd`)
   - Trigger phrases in the `description` frontmatter field
5. When triggered, Claude receives the skill's markdown content as instructions

### Testing Locally
Use `claude --plugin-dir .` from project root to test the plugin before publishing.

## Common Patterns

### File Creation in Skills
When a skill needs to create files:
- Check if file exists first
- If exists, prompt user before overwriting
- Use exact content blocks so Claude creates consistent output
- For scripts, remind about executable permissions

### Progress Tracking
The Ralph workflow uses `progress.txt` to:
- Record learnings from each iteration
- Pass context to future iterations
- Track what was implemented and what failed

Always read the Learnings section at the start of each iteration.

### Committing Changes
- Only commit if tests pass
- Use conventional commit format: `feat: [description]`
- Never commit broken code

## Contributing

When modifying this plugin:
1. Test the plugin by running `claude --plugin-dir .` from project root
2. Verify `/ralph-prd:prd` command is available
3. Verify skill generates PRD.md correctly
4. Ensure `scripts/ralph.sh` is accessible
5. Update this AGENTS.md if new patterns emerge
